// facial_expression_game.dart
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '/widgets/headerGame.dart';

class FaceQuestion {
  final String id;
  final String prompt;
  final String requiredLabel;
  final String fruitAsset;

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
  CameraController? _cameraController;
  bool _cameraInitialized = false;
  List<CameraDescription>? _cameras;

  late Interpreter _interpreter;
  bool _modelLoaded = false;
  List<String> _labels = [];

  late final List<FaceQuestion> _questions = [
    const FaceQuestion(
      id: 'q1',
      prompt: '1. ทำหน้ายิ้ม (Happy)',
      requiredLabel: 'happy',
      fruitAsset: 'assets/game_assets/prototype/fruit/banana.png',
    ),
    const FaceQuestion(
      id: 'q2',
      prompt: '2. ทำหน้าเศร้า (Sad)',
      requiredLabel: 'sad',
      fruitAsset: 'assets/game_assets/prototype/fruit/apple.png',
    ),
    const FaceQuestion(
      id: 'q3',
      prompt: '3. ทำหน้าโกรธ (Angry)',
      requiredLabel: 'angry',
      fruitAsset: 'assets/game_assets/prototype/fruit/strawberry.png',
    ),
    const FaceQuestion(
      id: 'q4',
      prompt: '4. ทำหน้ายู่ (Disgust)',
      requiredLabel: 'disgust',
      fruitAsset: 'assets/game_assets/prototype/fruit/lemon.png',
    ),
    const FaceQuestion(
      id: 'q5',
      prompt: '5. ทำหน้างง (Surprised)',
      requiredLabel: 'surprised',
      fruitAsset: 'assets/game_assets/prototype/fruit/kiwi.png',
    ),
    const FaceQuestion(
      id: 'q6',
      prompt: '6. ทำหน้าเฉยๆ (Neutral)',
      requiredLabel: 'neutral',
      fruitAsset: 'assets/game_assets/prototype/fruit/watermelon.png',
    ),
    const FaceQuestion(
      id: 'q7',
      prompt: '7. ทำหน้าตื่นเต้น (Excited ~ surprised)',
      requiredLabel: 'surprised',
      fruitAsset: 'assets/game_assets/prototype/fruit/pineapple.png',
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

  int _currentIndex = 0;
  int _score = 0;

  Timer? _questionTimer;
  int _timeLeft = 30;

  Timer? _inferenceTimer;
  final int _inferenceIntervalMs = 500;

  String? _lastLabel;
  double _lastConfidence = 0.0;

  final GlobalKey _stackKey = GlobalKey();

  CameraImage? _latestImage;
  bool _isRunningInference = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCameraAndModel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopAll();
    super.dispose();
  }

  void _stopAll() {
    _questionTimer?.cancel();
    _inferenceTimer?.cancel();
    _cameraController?.dispose();
    _interpreter.close();
  }

  Future<void> _initCameraAndModel() async {
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
      setState(() {});

      await _cameraController!.startImageStream(_processCameraImage);
    } catch (e) {
      print("Camera init error: $e");
    }

    try {
      _interpreter = await Interpreter.fromAsset('AI_Model/model.tflite');
      final labelData = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/tflite/labels.txt');
      _labels = labelData.split('\n').map((e) => e.trim()).toList();
      _modelLoaded = true;
      setState(() {});
    } catch (e) {
      print("Interpreter load error: $e");
    }

    _startQuestionTimer();
    _inferenceTimer?.cancel();
    _inferenceTimer = Timer.periodic(
      Duration(milliseconds: _inferenceIntervalMs),
      (_) {
        _checkMatchAndAdvanceIfNeeded();
      },
    );
  }

  void _processCameraImage(CameraImage image) {
    _latestImage = image;
    if (!_isRunningInference) {
      _isRunningInference = true;
      _runModelOnFrame(image).whenComplete(() => _isRunningInference = false);
    }
  }

  Future<void> _runModelOnFrame(CameraImage image) async {
    if (!_modelLoaded) return;

    try {
      // Convert YUV420 to RGB
      final rgb = _yuv420ToImage(image);

      // Resize to model input size (assume 48x48 or adjustตามโมเดลคุณ)
      final inputImage = ImageProcessorBuilder()
          .add(ResizeOp(48, 48, ResizeMethod.BILINEAR))
          .build()
          .process(
            TensorImage.fromUint8List(
              rgb,
              shape: [image.height, image.width, 3],
            ),
          );

      TensorBuffer outputBuffer = TensorBufferFloat([_labels.length]);

      _interpreter.run(inputImage.buffer, outputBuffer.buffer);

      final confidences = outputBuffer.getDoubleList();
      int maxIndex = 0;
      double maxConf = 0.0;
      for (int i = 0; i < confidences.length; i++) {
        if (confidences[i] > maxConf) {
          maxConf = confidences[i];
          maxIndex = i;
        }
      }
      _lastLabel = _labels[maxIndex].toLowerCase();
      _lastConfidence = maxConf;

      if (mounted) setState(() {});
    } catch (e) {
      print("Inference error: $e");
    }
  }

  Uint8List _yuv420ToImage(CameraImage image) {
    // convert CameraImage YUV420 to RGB bytes
    // สำหรับเวอร์ชันทดลอง อาจใช้ library image package หรือ plugin ที่ช่วย
    // placeholder: return empty Uint8List
    return Uint8List(image.width * image.height * 3);
  }

  void _checkMatchAndAdvanceIfNeeded() {
    if (_lastLabel == null) return;
    final curQ = _questions[_currentIndex];
    final need = curQ.requiredLabel.toLowerCase();
    final confThreshold = 0.60;
    if (_lastLabel == need && _lastConfidence >= confThreshold) {
      _score += 1;
      _goNextQuestion(passed: true);
    }
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _timeLeft = 30;
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _timeLeft -= 1;
      });
      if (_timeLeft <= 0) {
        _goNextQuestion(passed: false);
      }
    });
  }

  void _goNextQuestion({required bool passed}) {
    _questionTimer?.cancel();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex += 1;
          _lastLabel = null;
          _lastConfidence = 0.0;
        });
        _startQuestionTimer();
      } else {
        _finishGame();
      }
    });
  }

  void _finishGame() {
    _inferenceTimer?.cancel();
    _questionTimer?.cancel();
    _cameraController?.stopImageStream();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('สรุปผล'),
          content: Text('คุณได้คะแนน $_score จาก ${_questions.length} ข้อ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentIndex = 0;
                  _score = 0;
                  _lastLabel = null;
                  _lastConfidence = 0.0;
                });
                _startQuestionTimer();
              },
              child: const Text('เล่นอีกครั้ง'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).maybePop();
              },
              child: const Text('กลับ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  // ... progress bar + avatar + question card + play area (เหมือนเดิม)
                  // top-left: timer + prediction text
                  Text(
                    '$_lastLabel : ${(_lastConfidence * 100).toStringAsFixed(0)}%',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
