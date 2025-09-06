import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameS.dart';

class DragFruitGame extends StatefulWidget {
  const DragFruitGame({Key? key}) : super(key: key);

  @override
  State<DragFruitGame> createState() => _DragFruitGameState();
}

class _DragFruitGameState extends State<DragFruitGame>
    with SingleTickerProviderStateMixin {
  int currentLevel = 0;
  int score = 0;
  int? selectedChoice;

  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  late AnimationController _eatController;
  late Animation<double> _shrinkAnimation;

  // ✅ ข้อมูลเกม
  final List<Map<String, dynamic>> gameData = [
    {
      "sentence": "Please give me a banana.",
      "questionImage": "assets/images/banana.png",
      "choice1": "assets/images/banana.png",
      "choice2": "assets/images/grape.png",
      "correctAnswerIndex": 0,
    },
    {
      "sentence": "Please give me an apple.",
      "questionImage": "assets/images/apple.png",
      "choice1": "assets/images/apple.png",
      "choice2": "assets/images/orange.png",
      "correctAnswerIndex": 0,
    },
    {
      "sentence": "Please give me an orange.",
      "questionImage": "assets/images/orange.png",
      "choice1": "assets/images/grape.png",
      "choice2": "assets/images/orange.png",
      "correctAnswerIndex": 1,
    },
    // ... เพิ่มข้ออื่นๆ ตามต้องการ
  ];

  @override
  void initState() {
    super.initState();

    _eatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _shrinkAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_eatController);

    // ฟังคำถามแรก
    _speakCurrentQuestion();
  }

  @override
  void dispose() {
    _eatController.dispose();
    flutterTts.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _speakCurrentQuestion() async {
    await flutterTts.stop();
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(gameData[currentLevel]["sentence"]);
  }

  void _handleDrop(int droppedIndex) async {
    final correctIndex = gameData[currentLevel]["correctAnswerIndex"];

    if (droppedIndex == correctIndex) {
      // ✅ ถูกรางวัล
      setState(() {
        selectedChoice = droppedIndex;
      });

      await _eatController.forward();
      await audioPlayer.play(AssetSource("sounds/correct.mp3"));

      setState(() {
        score++;
        if (currentLevel < gameData.length - 1) {
          currentLevel++;
          selectedChoice = null;
          _eatController.reset();
          _speakCurrentQuestion();
        } else {
          _goToSummary();
        }
      });
    } else {
      // ❌ ผิด → สั่น + เสียง + แจ้งเตือน
      HapticFeedback.heavyImpact();
      await audioPlayer.play(AssetSource("sounds/wrong.mp3"));
      _showWrongShake();
    }
  }

  void _showWrongShake() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Wrong! Try again."),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  void _goToSummary() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => buildSummaryScreen_S(
          context: context,
          totalScore: score,
          currentLevel: 2,
        ),
      ),
    );
  }

  double _calculateProgress(double maxWidth) {
    return maxWidth * ((currentLevel + 1) / gameData.length);
  }

  double _calculateIconPosition(double maxWidth, double iconWidth) {
    final progress = _calculateProgress(maxWidth);
    return (progress - iconWidth / 2).clamp(0, maxWidth - iconWidth);
  }

  Widget _buildChoice(int index, double size) {
    final choicePath = gameData[currentLevel]["choice${index + 1}"];
    final isSelected = selectedChoice == index;

    return Draggable<int>(
      data: index,
      feedback: Material(
        color: Colors.transparent,
        child: Image.asset(choicePath, width: size, height: size),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: Image.asset(choicePath, width: size, height: size),
      ),
      child: AnimatedBuilder(
        animation: _eatController,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _shrinkAnimation.value : 1.0,
            child: Image.asset(choicePath, width: size, height: size),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          child: Column(
            children: [
              // Header
              GameHeader(
                money: "12,000,000.00",
                profileImage: "assets/images/head.png",
              ),
              const SizedBox(height: 20),

              // Progress Bar + Icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth - screenWidth * 0.05;
                    final iconWidth = screenWidth * 0.06;
                    return Stack(
                      children: [
                        // Progress Line
                        Positioned(
                          top: screenHeight * 0.01,
                          child: Container(
                            width: _calculateProgress(maxWidth),
                            height: screenHeight * 0.012,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF65A3B),
                              borderRadius: BorderRadius.circular(
                                screenHeight * 0.006,
                              ),
                            ),
                          ),
                        ),
                        // Icon
                        Positioned(
                          top: 0,
                          left: _calculateIconPosition(maxWidth, iconWidth),
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

              // ตัวคำสั่ง + กล่องลาก
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // คำสั่ง
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        gameData[currentLevel]["sentence"],
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // รูปภาพเป้าหมาย DragTarget
                    DragTarget<int>(
                      builder: (context, candidateData, rejectedData) {
                        return Image.asset(
                          gameData[currentLevel]["questionImage"],
                          width: screenWidth * 0.4,
                          height: screenWidth * 0.4,
                        );
                      },
                      onAccept: (index) => _handleDrop(index),
                    ),

                    const SizedBox(height: 30),

                    // ตัวเลือก Drag
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildChoice(0, screenWidth * 0.25),
                        _buildChoice(1, screenWidth * 0.25),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
