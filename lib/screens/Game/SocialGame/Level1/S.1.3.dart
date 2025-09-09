// facial_expression_game.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../summaryGameS.dart';
import '/widgets/headerGame.dart';
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
  // Camera
  CameraController? _cameraController;
  bool _cameraInitialized = false;
  List<CameraDescription>? _cameras;

  // Game questions (10 ข้อ)
  late final List<FaceQuestion> _questions = [
    const FaceQuestion(
      id: 'q1',
      prompt: '1. รสชาติหอม หวาน อร่อย',
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
      prompt: '3. องุ่นพวงนี้รสชาติหวานอร่อย ทำหน้ามีความสุขให้ดูหน่อย',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/grab.png',
    ),
    const FaceQuestion(
      id: 'q4',
      prompt: '4. กีวี่ลูกนี้เปรี้ยวมาก ๆ ทำหน้าเปรี้ยวจี๊ดให้ดูหน่อย',
      requiredLabel: 'disgust',
      fruitAsset: 'assets/game_assets/prototype/fruit/kiwi.png',
    ),
    const FaceQuestion(
      id: 'q5',
      prompt: '5. สตรอว์เบอร์รี่หวานอร่อย ทำหน้ามีความสุขหน่อย',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/strawberry.png',
    ),
    const FaceQuestion(
      id: 'q6',
      prompt: '6. มะพร้าวหอมมัน รสชาติอร่อย ทำหน้ามีความสุขหน่อย',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/coconut.png',
    ),
    const FaceQuestion(
      id: 'q7',
      prompt: '7. ทำหน้าตื่นเต้น (Excited ~ Surprised)',
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
      prompt: '10. ทำหน้าเฉย ๆ',
      requiredLabel: 'neutral',
      fruitAsset: 'assets/game_assets/prototype/fruit/grab.png',
    ),
  ];

  // ยอมรับ alias ของ label เล็กน้อยเพื่อความยืดหยุ่น
  final Map<String, String> _labelAliases = const {
    'smile': 'happy',
    'frown': 'sad',
    'disgusted': 'disgust',
    'sour': 'disgust',
    'excited': 'surprised',
    'shock': 'surprised',
    'neutral': 'neutral',
    'angry': 'angry',
    'happy': 'happy',
    'sad': 'sad',
    'surprised': 'surprised',
    'disgust': 'disgust',
  };

  int _currentIndex = 0;
  int _score = 0;

  // per-question timer
  Timer? _questionTimer;
  int _timeLeft = 15; // วินาที

  // prediction result (debug/state)
  String? _lastLabel;
  double _lastConfidence = 0.0;

  // UI
  final GlobalKey _stackKey = GlobalKey();
  bool _isGameFinished = false;
  bool _isCapturing = false;

  // Threshold ผ่าน
  static const double _passThreshold = 0.60;

  /// Roboflow config (ใส่ค่าจริงก่อนใช้งาน)
  static const String _rfApiKey = "EmsyUjB6F24BkOOZO3g4";
  static const String _rfProject =
      "human-face-expression-git8p"; // เช่น human-face-expression-git8p
  static const String _rfVersion = "2"; // เช่น 1

  Uri _rfDetectUri() => Uri.parse(
    "https://serverless.roboflow.com/$_rfProject/$_rfVersion?api_key=$_rfApiKey",
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
      final cameras = await availableCameras();
      _cameras = cameras;
      final front = _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );
      _cameraController = CameraController(
        front,
        ResolutionPreset.high, // ภาพคมขึ้น (ปรับได้)
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

  String _canonicalize(String raw) {
    final lower = raw.toLowerCase().trim();
    return _labelAliases[lower] ?? lower;
    // ถ้า label ไม่อยู่ใน alias จะใช้ lower-case เดิม
  }

  bool _isPass(String predicted, double conf) {
    final required = _canonicalize(_questions[_currentIndex].requiredLabel);
    final got = _canonicalize(predicted);
    return (got == required) && conf >= _passThreshold;
  }

  /// ✅ ฟังก์ชันถ่ายรูป + ส่ง Roboflow DETECT API
  /// ✅ ฟังก์ชันถ่ายรูป + ส่ง Roboflow DETECT API
  Future<void> _captureAndSendToRoboflow() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      debugPrint("❌ Camera not ready");
      return;
    }
    if (_isCapturing) return;
    _isCapturing = true;

    try {
      // 1) ถ่ายรูป
      final XFile file = await _cameraController!.takePicture();
      final bytes = await file.readAsBytes();

      // 2) สร้าง URL ตาม Roboflow Hosted Inference
      final uri = Uri.parse(
        "https://serverless.roboflow.com/human-face-expression-git8p/1?api_key=EmsyUjB6F24BkOOZO3g4",
      );

      // 3) ส่งภาพไป Roboflow
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/octet-stream"},
        body: bytes,
      );

      // 4) ตรวจผลลัพธ์
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result["predictions"] != null && result["predictions"].isNotEmpty) {
          final preds = result["predictions"] as List;
          preds.sort(
            (a, b) => ((b["confidence"] ?? 0) as num).compareTo(
              (a["confidence"] ?? 0) as num,
            ),
          );
          final pred = preds.first;

          final String label = (pred["class_name"] ?? pred["class"] ?? "")
              .toString();
          final double conf = (pred["confidence"] as num).toDouble();

          debugPrint("✅ Predict: $label conf=$conf");

          if (_isPass(label, conf)) {
            _goNextQuestion(passed: true);
          } else {
            TtsService.speak("ลองปรับสีหน้าอีกครั้ง", rate: 0.9, pitch: 1.0);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("ยังไม่ตรง ลองใหม่อีกครั้งนะ")),
              );
            }
            _isCapturing = false;
          }
        } else {
          debugPrint("⚠️ ไม่พบการทำนายจาก API");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("ไม่พบการทำนายจากภาพ")),
            );
          }
          _isCapturing = false;
        }
      } else {
        debugPrint("❌ Roboflow error: ${response.statusCode} ${response.body}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("เกิดข้อผิดพลาดจากเซิร์ฟเวอร์")),
          );
        }
        _isCapturing = false;
      }
    } catch (e) {
      debugPrint("❌ Capture error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ถ่ายภาพหรือส่งไม่สำเร็จ")),
        );
      }
      _isCapturing = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ---------------- Header ----------------
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),

                  const SizedBox(height: 12),

                  // ---------------- Progress Bar แบบในภาพ ----------------
                  _ProgressWithAvatar(
                    progress: (_currentIndex + 1) / _questions.length,
                    avatarAsset: "assets/images/head.png",
                  ),

                  const SizedBox(height: 16),

                  // ---------------- Avatar กลมกลางบน ----------------
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: const AssetImage(
                        "assets/images/head.png",
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---------------- การ์ดโจทย์ ----------------
                  _PromptCard(text: curQ.prompt),

                  const SizedBox(height: 16),

                  // ---------------- กรอบกล้อง + ปุ่มผลไม้ซ้อนทับ ----------------
                  // อัตราส่วนใกล้เคียงภาพ (แนวตั้ง)
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          key: _stackKey,
                          alignment: Alignment.center,
                          children: [
                            // กรอบมุมโค้ง + เส้นขาว
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child:
                                  _cameraInitialized &&
                                      _cameraController != null
                                  ? CameraPreview(_cameraController!)
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),

                            // ปุ่มผลไม้กลมซ้อนทับด้านล่าง (กด = ถ่ายรูป)
                            Positioned(
                              bottom: 12,
                              child: GestureDetector(
                                onTap: _isCapturing
                                    ? null
                                    : _captureAndSendToRoboflow,
                                child: Container(
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    curQ.fruitAsset,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ---------------- ข้อมูลข้างล่างเล็กน้อย ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ข้อที่ ${_currentIndex + 1} / ${_questions.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'คะแนน: $_score',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'เวลา: $_timeLeft วิ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // ถ้าต้องการ debug label
                  // Text('Label: ${_lastLabel ?? "-"} (${_lastConfidence.toStringAsFixed(2)})'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// --------------------
/// Widgets เฉพาะ UI
/// --------------------

class _PromptCard extends StatelessWidget {
  final String text;
  const _PromptCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF5B5B5B),
        ),
      ),
    );
  }
}

class _ProgressWithAvatar extends StatelessWidget {
  final double progress; // 0..1
  final String avatarAsset;
  const _ProgressWithAvatar({
    required this.progress,
    required this.avatarAsset,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) {
        final barHeight = 14.0;
        final handleSize = 28.0;
        final barWidth = constraints.maxWidth;
        final x = (barWidth - handleSize) * clamped;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(barHeight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(barHeight),
                child: LinearProgressIndicator(
                  value: clamped,
                  minHeight: barHeight,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    const Color(0xFFE97359), // เฉดแดงส้มอ่อนตามภาพ
                  ),
                ),
              ),
            ),
            Positioned(
              left: x,
              top: -(handleSize / 2) + (barHeight / 2),
              child: Container(
                width: handleSize,
                height: handleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(avatarAsset, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// สามเหลี่ยมด้านล่าง avatar (ถ้ายังต้องใช้ที่อื่น)
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
