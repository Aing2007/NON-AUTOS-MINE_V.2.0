// facial_expression_game.dart
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../summaryGameS.dart';
import '/widgets/headerGame.dart'; // ใช้ Header ของคุณ
import '../../../../AIfunction/TTS.dart';

/// --------------------
/// Models (โจทย์ 10 ข้อ)
/// --------------------
class FaceQuestion {
  final String id;
  final String prompt; // ข้อความโจทย์ เช่น "ทำหน้ายิ้ม"
  final String requiredLabel; // label หลักที่ต้องการ
  final String fruitAsset; // path ของผลไม้

  const FaceQuestion({
    required this.id,
    required this.prompt,
    required this.requiredLabel,
    required this.fruitAsset,
  });
}

class FacialExpressionGame extends StatefulWidget {
  const FacialExpressionGame({Key? key}) : super(key: key);

  @override
  State<FacialExpressionGame> createState() => _FacialExpressionGameState();
}

class _FacialExpressionGameState extends State<FacialExpressionGame>
    with WidgetsBindingObserver {
  // camera
  CameraController? _cameraController;
  bool _cameraInitialized = false;
  List<CameraDescription>? _cameras;

  // Game questions (10 ข้อ)
  late final List<FaceQuestion> _questions = [
    const FaceQuestion(
      id: 'q1',
      prompt: '1.กล้วยมีรสหวานมากเลย ทำหน้ายิ้มหน่อย',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/banana.png',
    ),
    const FaceQuestion(
      id: 'q2',
      prompt: '2. แอปเปิ้ลลูกนี้เปรี้ยวมากเลย ทำหน้ายู่ให้ดูหน่อย',
      requiredLabel: 'sad',
      fruitAsset: 'assets/game_assets/prototype/fruit/apple.png',
    ),
    const FaceQuestion(
      id: 'q3',
      prompt: '3.องุ่นพวงนี้รสชาติหวามอร่อย ทำหน้ามีความสุขให้ดูหน่อย',
      requiredLabel:
          'angry', // เดิมไม่สอดคล้องกับ prompt -> แก้ด้วย acceptable labels ด้านล่าง
      fruitAsset: 'assets/game_assets/prototype/fruit/grab.png',
    ),
    const FaceQuestion(
      id: 'q4',
      prompt: '4. กีวี่ลูกนี้เปรี้ยวมากๆเลย ไหนทำหน้าเปรี้ยวจี๊ดให้ดูหน่อย',
      requiredLabel: 'disgust',
      fruitAsset: 'assets/game_assets/prototype/fruit/kiwi.png',
    ),
    const FaceQuestion(
      id: 'q5',
      prompt: '5. สตอเบอรี่ลูกนี้หวาน รสชาติอร่อย ทำหน้ามีความสุขหน่อย',
      requiredLabel:
          'surprised', // เดิมไม่สอดคล้องกับ prompt -> แก้ด้วย acceptable labels ด้านล่าง
      fruitAsset: 'assets/game_assets/prototype/fruit/strawberry.png',
    ),
    const FaceQuestion(
      id: 'q6',
      prompt: '6. มะพร้าวลูกนี้หอมมันมาก รสชาติอร่อย ทำหน้ามีความสุขหน่อย',
      requiredLabel:
          'neutral', // เดิมไม่สอดคล้องกับ prompt -> แก้ด้วย acceptable labels ด้านล่าง
      fruitAsset: 'assets/game_assets/prototype/fruit/coconut.png',
    ),
    const FaceQuestion(
      id: 'q7',
      prompt: '7. ทำหน้าตื่นเต้น (Excited ~ surprised)',
      requiredLabel: 'surprised',
      fruitAsset: 'assets/game_assets/prototype/fruit/lemon.png',
    ),
    const FaceQuestion(
      id: 'q8',
      prompt: '8. ทำหน้าตกใจ (Surprised)',
      requiredLabel: 'surprised',
      fruitAsset: 'assets/game_assets/prototype/fruit/peach.png',
    ),
    const FaceQuestion(
      id: 'q9',
      prompt: '9. ทำหน้ายิ้มแบบกว้าง (Happy)',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/coconut.png',
    ),
    const FaceQuestion(
      id: 'q10',
      prompt: '10. ทำหน้าเฉยๆ',
      requiredLabel: 'neutral',
      fruitAsset: 'assets/game_assets/prototype/fruit/grab.png',
    ),
  ];

  // ✅ แผนที่ label ที่ยอมรับได้ต่อข้อ (เพื่อชดเชย prompt/requiredLabel ที่เคยไม่ตรง)
  // ไม่กระทบ UI เพราะเป็นลอจิกภายในเท่านั้น
  late final Map<String, Set<String>> _acceptableLabelsByQuestionId = {
    'q1': {'happy', 'smile'},
    'q2': {'sad', 'frown'},
    // q3: prompt ขอความสุข แต่ requiredLabel เดิมเป็น angry -> ยอมรับทั้ง 'happy' และ 'angry' เพื่อไม่เปลี่ยน UI
    'q3': {'happy', 'angry'},
    'q4': {'disgust', 'disgusted', 'sour'},
    // q5: prompt ขอความสุข แต่ requiredLabel เดิมเป็น surprised -> ยอมรับทั้ง 'happy' และ 'surprised'
    'q5': {'happy', 'surprised'},
    // q6: prompt บอกมีความสุข แต่ requiredLabel เดิม neutral -> ยอมรับทั้ง 'happy' และ 'neutral'
    'q6': {'neutral', 'happy'},
    'q7': {'surprised', 'excited'},
    'q8': {'surprised', 'shock'},
    'q9': {'happy', 'smile'},
    'q10': {'neutral'},
  };

  // mapping alias -> canonical
  final Map<String, String> _labelAliases = const {
    'smile': 'happy',
    'frown': 'sad',
    'disgusted': 'disgust',
    'sour': 'disgust',
    'excited': 'surprised',
    'shock': 'surprised',
  };

  int _currentIndex = 0;
  int _score = 0;

  // per-question timer
  Timer? _questionTimer;
  int _timeLeft = 30; // วินาที

  // prediction result
  String? _lastLabel;
  double _lastConfidence = 0.0;

  // UI reuse
  final GlobalKey _stackKey = GlobalKey();

  // game finished flag
  bool _isGameFinished = false;

  // ✅ ป้องกันกดปุ่มถ่ายรัว ๆ / ส่งซ้ำ
  bool _isCapturing = false;

  // ✅ ปรับ threshold ผ่านได้ตามต้องการ
  static const double _passThreshold = 0.60;

  /// Roboflow config (ปรับค่าจริงก่อนใช้งาน)
  static const String _rfApiKey = "rf_OqbLvRlnPqg3KIvM9Jr5PHoD8MC3";
  static const String _rfProject = "human-face-expression-git8p";
  static const String _rfVersion = "1";

  Uri _rfClassifyUri() => Uri.parse(
    "https://classify.roboflow.com/$_rfProject/$_rfVersion?api_key=$_rfApiKey",
  );
  Uri _rfDetectUri() => Uri.parse(
    "https://detect.roboflow.com/$_rfProject/$_rfVersion?api_key=$_rfApiKey",
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_questions.isNotEmpty) {
        TtsService.speak(_questions[0].prompt, rate: 0.5, pitch: 1.0);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAll();
    super.dispose();
  }

  void _stopAll() {
    _questionTimer?.cancel();
    _cameraController?.dispose();
    _cameraInitialized = false;
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      final front = _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );
      _cameraController = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();
      _cameraInitialized = true;
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Camera init error: $e");
    }

    _startQuestionTimer();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _timeLeft = 15;
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _timeLeft -= 1);
      if (_timeLeft <= 0) _goNextQuestion(passed: false);
    });
  }

  void _goNextQuestion({required bool passed}) {
    _questionTimer?.cancel();
    if (passed) {
      _score++;
      TtsService.speak("เยี่ยมมาก! ถูกต้อง", rate: 0.9, pitch: 1.05);
    }
    // หน่วงนิดหน่อยเพื่อให้ผู้เล่นรับรู้ผล
    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex += 1;
          _lastLabel = null;
          _lastConfidence = 0.0;
          _isCapturing = false;
        });
        TtsService.speak(
          _questions[_currentIndex].prompt,
          rate: 0.5,
          pitch: 1.0,
        );
        _startQuestionTimer();
      } else {
        _finishGame();
      }
    });
  }

  void _finishGame() {
    setState(() {
      _isGameFinished = true;
    });
  }

  // ✅ รวมผลลัพธ์จากทั้ง classify และ detect ให้ได้ class + confidence
  // รูปแบบที่รองรับ:
  // - Classify: { "top": {"class_name":"happy","confidence":0.87}, ... }
  //             หรือ { "predictions": [{"class":"happy","confidence":0.87}, ...] }
  // - Detect:   { "predictions": [{"class":"happy","confidence":0.87, ...}, ...] }
  Map<String, dynamic>? _extractPrediction(dynamic jsonBody) {
    if (jsonBody == null) return null;

    // classify: top
    final top = jsonBody['top'];
    if (top is Map) {
      final c = (top['class_name'] ?? top['class'])?.toString();
      final conf = (top['confidence'] is num)
          ? (top['confidence'] as num).toDouble()
          : null;
      if (c != null && conf != null) {
        return {'class': c, 'confidence': conf};
      }
    }

    // classify/detect: predictions[0]
    if (jsonBody['predictions'] is List &&
        (jsonBody['predictions'] as List).isNotEmpty) {
      final p = (jsonBody['predictions'] as List).first;
      if (p is Map) {
        final c = (p['class_name'] ?? p['class'])?.toString();
        final conf = (p['confidence'] is num)
            ? (p['confidence'] as num).toDouble()
            : null;
        if (c != null && conf != null) {
          return {'class': c, 'confidence': conf};
        }
      }
    }

    return null;
  }

  String _canonicalize(String raw) {
    final lower = raw.toLowerCase().trim();
    return _labelAliases[lower] ?? lower;
  }

  bool _isPassForCurrentQuestion(String predictedLabel, double conf) {
    final q = _questions[_currentIndex];
    final acceptSet =
        _acceptableLabelsByQuestionId[q.id] ?? {q.requiredLabel.toLowerCase()};
    final canonical = _canonicalize(predictedLabel);
    return acceptSet.map((e) => _canonicalize(e)).contains(canonical) &&
        conf >= _passThreshold;
  }

  /// ✅ ฟังก์ชันถ่ายรูป + ส่ง Roboflow API
  Future<void> _captureAndSendToRoboflow() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      debugPrint("❌ Camera not ready");
      return;
    }
    if (_isCapturing) return;
    _isCapturing = true;

    try {
      // ถ่ายรูป
      final XFile file = await _cameraController!.takePicture();
      final bytes = await file.readAsBytes();

      // ลองเรียก classify ก่อน ถ้า error ค่อย fallback เป็น detect
      http.Response? response;
      try {
        response = await http.post(
          _rfClassifyUri(),
          headers: {"Content-Type": "application/octet-stream"},
          body: bytes,
        );
      } catch (_) {
        // เฉย ๆ แล้วค่อยลอง detect
      }

      if (response == null || response.statusCode >= 400) {
        response = await http.post(
          _rfDetectUri(),
          headers: {"Content-Type": "application/octet-stream"},
          body: bytes,
        );
      }

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final pred = _extractPrediction(result);

        if (pred != null) {
          final String label = (pred['class'] as String?) ?? '';
          final double conf = (pred['confidence'] as double?) ?? 0.0;

          if (!mounted) return;
          setState(() {
            _lastLabel = label;
            _lastConfidence = conf;
          });

          debugPrint("✅ Predict: $_lastLabel conf=$_lastConfidence");

          if (_isPassForCurrentQuestion(label, conf)) {
            _goNextQuestion(passed: true);
          } else {
            // ยังไม่ผ่าน ให้ลองใหม่ได้ (ไม่ตัดเวลาเพิ่ม)
            TtsService.speak("ลองปรับสีหน้าอีกครั้ง", rate: 0.9, pitch: 1.0);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("ยังไม่ตรง ลองใหม่อีกครั้งนะ")),
              );
            }
            _isCapturing = false;
          }
        } else {
          if (mounted) {
            setState(() {
              _lastLabel = "ไม่พบ";
              _lastConfidence = 0.0;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("ไม่พบการทำนายจากภาพ ลองใหม่อีกครั้ง"),
              ),
            );
          }
          _isCapturing = false;
        }
      } else {
        debugPrint("❌ Roboflow error: ${response.body}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("เกิดข้อผิดพลาดจากเซิร์ฟเวอร์: ${response.body}"),
            ),
          );
        }
        _isCapturing = false;
      }
    } catch (e) {
      debugPrint("❌ Capture error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ถ่ายภาพหรือส่งไม่สำเร็จ ลองอีกครั้ง")),
        );
      }
      _isCapturing = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // จัดการกล้องเมื่อแอปพัก/กลับมา
    if (_cameraController == null) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _cameraController?.dispose();
      _cameraInitialized = false;
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isGameFinished) {
      return buildSummaryScreen_S(
        context: context,
        totalScore: _score,
        currentLevel: 3,
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final curQ = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGS.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // Progress bar
                  // ... (โค้ดเดิมทั้งหมด ไม่เปลี่ยนแปลง) ...
                  const SizedBox(height: 20),
                  // Main play area
                  AspectRatio(
                    aspectRatio: 9 / 12,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            key: _stackKey,
                            children: [
                              // ✅ ใส่ CameraPreview ลงในตำแหน่งเดิม (ไม่เปลี่ยน UI/โครง)
                              if (_cameraInitialized &&
                                  _cameraController != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CameraPreview(_cameraController!),
                                )
                              else
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),

                              // ✅ ปุ่ม Capture ด้านล่าง (เดิม)
                              Positioned(
                                bottom: 20,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: ElevatedButton.icon(
                                    onPressed: _isCapturing
                                        ? null
                                        : _captureAndSendToRoboflow,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      _isCapturing ? "กำลังตรวจ..." : "ถ่ายรูป",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bottom info (เดิม)
                  Text(
                    'ข้อที่ ${_currentIndex + 1} / ${_questions.length}    คะแนน: $_score',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // (ไม่บังคับแสดง แต่ถ้าต้องการ debug ก็อ่านได้จากตัวแปร)
                  // Text('Label: ${_lastLabel ?? "-"} (${_lastConfidence.toStringAsFixed(2)})'),
                  // Text('เวลา: $_timeLeft วินาที'),
                  // Text(curQ.prompt),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// สามเหลี่ยมด้านล่าง avatar
class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
