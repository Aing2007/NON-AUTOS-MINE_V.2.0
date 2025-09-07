// facial_expression_game.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../summaryGameS.dart';
import '/widgets/headerGame.dart'; // ใช้ Header ของคุณ
import '../../../../AIfunction/TTS.dart';

/// --------------------
/// Models (โจทย์ 10 ข้อ)
/// --------------------
class FaceQuestion {
  final String id;
  final String prompt; // ข้อความโจทย์ เช่น "ทำหน้ายิ้ม"
  final String requiredLabel; // label ที่ต้องการ (mock)
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
      requiredLabel: 'angry',
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
      requiredLabel: 'surprised',
      fruitAsset: 'assets/game_assets/prototype/fruit/strawberry.png',
    ),
    const FaceQuestion(
      id: 'q6',
      prompt: '6. มะพร้าวลูกนี้หอมมันมาก รสชาติอร่อย ทำหน้ามีความสุขหน่อย',
      requiredLabel: 'neutral',
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

  int _currentIndex = 0;
  int _score = 0;

  // per-question timer
  Timer? _questionTimer;
  int _timeLeft = 30; // วินาที

  // mock prediction result (แทนที่ tflite)
  String? _lastLabel;
  double _lastConfidence = 0.0;

  // UI reuse
  final GlobalKey _stackKey = GlobalKey();

  // game finished flag
  bool _isGameFinished = false;

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
      setState(() {});
    } catch (e) {
      print("Camera init error: $e");
    }

    _startQuestionTimer();
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _timeLeft = 15;
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _timeLeft -= 1);
      if (_timeLeft <= 0) _goNextQuestion(passed: false);
    });
  }

  void _goNextQuestion({required bool passed}) {
    _questionTimer?.cancel();
    if (passed) _score++;
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex += 1;
          _lastLabel = null;
          _lastConfidence = 0.0;
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
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.035,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenHeight * 0.018),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth =
                            constraints.maxWidth - screenWidth * 0.05;
                        double iconWidth = screenWidth * 0.06;
                        double progress =
                            ((_currentIndex + 1) / _questions.length) *
                            maxWidth;
                        double leftPos =
                            screenWidth * 0.025 +
                            (progress - iconWidth / 2).clamp(
                              0,
                              maxWidth - iconWidth,
                            );
                        return Stack(
                          children: [
                            Positioned(
                              top:
                                  (screenHeight * 0.035 -
                                      screenHeight * 0.012) /
                                  2,
                              left: screenWidth * 0.025,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: progress,
                                height: screenHeight * 0.012,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF65A3B),
                                  borderRadius: BorderRadius.circular(
                                    screenHeight * 0.006,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: leftPos,
                              bottom: screenHeight * 0.003,
                              child: Container(
                                width: iconWidth,
                                height: screenHeight * 0.075,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/head.png'),
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
                  const SizedBox(height: 20),
                  // Center avatar + triangle
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/head.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomPaint(
                          size: Size(screenWidth * 0.05, screenWidth * 0.025),
                          painter: _TrianglePainter(),
                        ),
                      ],
                    ),
                  ),
                  // Question card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        curQ.prompt,
                        style: TextStyle(
                          fontFamily: 'Khula',
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF805E57),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Main play area
                  AspectRatio(
                    aspectRatio: 9 / 12,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            key: _stackKey,
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Opacity(
                                    opacity: 0.25,
                                    child: Image.asset(
                                      'assets/images/GameBG/StartBGS.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              if (_cameraInitialized &&
                                  _cameraController != null)
                                Positioned(
                                  top: screenWidth * 0.08,
                                  left: screenWidth * 0.28,
                                  child: SizedBox(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(pi),
                                        child: CameraPreview(
                                          _cameraController!,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                const Center(
                                  child: Text('กำลังเตรียมกล้อง...'),
                                ),
                              // Fruit overlay
                              Positioned(
                                bottom: constraints.maxHeight * 0.05,
                                left: screenWidth * 0.42,
                                top: screenWidth * 0.3,
                                child: Center(
                                  child: Container(
                                    width: constraints.maxWidth * 0.15,
                                    height: constraints.maxWidth * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        curQ.fruitAsset,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Timer + prediction (mock)
                              Positioned(
                                top: constraints.maxHeight * 0.03,
                                left: constraints.maxWidth * 0.04,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          160,
                                          160,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            size: 18,
                                            color: Colors.black54,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '$_timeLeft s',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          255,
                                          160,
                                          160,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'ผล: ${_lastLabel ?? "-"}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '(${(_lastConfidence * 100).toStringAsFixed(0)}%)',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Bottom info
                  Text(
                    'ข้อที่ ${_currentIndex + 1} / ${_questions.length}    คะแนน: $_score',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
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
