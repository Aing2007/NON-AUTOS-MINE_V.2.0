import 'dart:async';
import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameL.dart';
import '../../../../AIfunction/STT.dart'; // ใช้ STT Service
import 'package:non_autos_mine/screens/Game/LenguageGame/Level1/L.1.1.dart';
import '../summaryGameL.dart';

class SelectFruit3 extends StatefulWidget {
  const SelectFruit3({Key? key}) : super(key: key);

  @override
  State<SelectFruit3> createState() => _SelectFruitState();
}

class _SelectFruitState extends State<SelectFruit3> {
  int score = 0;
  int currentPage = 0;
  String recognizedText = ""; // ข้อความที่ฟังได้
  bool isListening = false; // สถานะไมโครโฟน

  Timer? _answerTimer;
  bool _canAnswer = false; // สถานะว่ายังตอบได้อยู่ไหม

  final List<Map<String, dynamic>> fruitPages = [
    {
      "question": "1.ฉันชอบกินกล้วย",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "2.ฉันอยากกินแอปเปิ้ล",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "3.ฉันชอบกินองุ่น",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "4.ฉันไม่อยากกินกีวี่",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "5.ฉันชอบกินสตอเบอรี่",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "6.ฉันอยากกินมะพร้าว",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "7.ฉันไม่ชอบกินเลมอน",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "8.ฉันไม่อยากกินลูกท้อ",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/peach.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "9.ฉันชอบกินสับปะรด",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "10.ฉันไม่ชอบกินแตงโม",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/watermelon.png",
          "isCorrect": true,
        },
      ],
    },
  ];

  late int totalPages = fruitPages.length;

  @override
  void initState() {
    super.initState();
    startNewQuestion(15); // เริ่มคำถามแรกพร้อมนับถอยหลัง 15 วิ
  }

  @override
  void dispose() {
    _answerTimer?.cancel();
    super.dispose();
  }

  // ✅ ฟังก์ชันเริ่มคำถามใหม่ พร้อมรับเวลาเป็นพารามิเตอร์
  void startNewQuestion(int countdownSeconds) {
    setState(() {
      recognizedText = "";
      _canAnswer = true;
    });

    // อ่านโจทย์ด้วย TTS
    TtsService.speak(
      fruitPages[currentPage]["question"] as String,
      rate: 0.5,
      pitch: 1.0,
    );

    // เริ่มจับเวลา
    _answerTimer?.cancel();
    _answerTimer = Timer(Duration(seconds: countdownSeconds), () {
      setState(() {
        _canAnswer = false; // หมดเวลา
      });
    });
  }

  // ✅ ตรวจสอบคำตอบจาก STT
  // ใน _checkAnswer
  void _checkAnswer(String text) {
    if (!_canAnswer) return; // ถ้าเวลาหมดแล้ว ไม่เพิ่ม score

    String question = fruitPages[currentPage]["question"] as String;
    String cleanQuestion = question.replaceAll(RegExp(r'^\d+\.'), '').trim();

    if (text.trim() == cleanQuestion) {
      setState(() {
        score++; // เพิ่มคะแนน
        _canAnswer = false; // กันบวกซ้ำ
      });
      _nextQuestion();
    }
  }

  // ✅ ไปโจทย์ถัดไป
  void _nextQuestion() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
      });
      startNewQuestion(15); // รีเซ็ต + เริ่มคำถามใหม่ (15 วิ)
    } else {
      print("Game Finished! Score: $score");
      TtsService.speak(
        "คุณทำคะแนนได้ $score คะแนน จากทั้งหมด $totalPages คะแนน",
        rate: 0.5,
        pitch: 1.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen(
            context: context,
            totalScore: score,
            currentLevel: 3,

            //onNextLevel: () {
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (_) => NextLevelScreen()),
            //      },
          ),
        ),
      );
    }
  }

  // เริ่มฟังเสียง
  Future<void> _startListening() async {
    setState(() => isListening = true);
    await SpeechService.startListening((text) {
      setState(() => recognizedText = text);
      _checkAnswer(text); // ตรวจสอบทุกครั้งที่ได้ข้อความ
    });
  }

  // หยุดฟังเสียง
  Future<void> _stopListening() async {
    await SpeechService.stopListening();
    setState(() => isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลังเกม
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/GameBG/StartBGL.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 384),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      GameHeader(
                        money: "12,000,000.00",
                        profileImage: "assets/images/head.png",
                      ),
                      const SizedBox(height: 20),
                      _buildProgressBar(),
                      _buildFloatingAvatar(),
                      _buildQuestion(),

                      // ผลไม้
                      // ปุ่มผลไม้เป็นแค่โชว์รูป ไม่สามารถกดไปคำถามต่อ
                      Column(
                        children: List.generate(
                          (fruitPages[currentPage]["fruits"] as List).length,
                          (index) {
                            final fruit =
                                fruitPages[currentPage]["fruits"][index];
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: screenHeight * 0.02,
                              ),
                              width: double.infinity,
                              height: screenHeight * 0.18,
                              child: _buildFruitButton(
                                imagePath: fruit["image"] as String,
                                isCorrect: fruit["isCorrect"] as bool,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ปุ่มไมโครโฟน + แสดงข้อความ
          Positioned(
            bottom: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (recognizedText.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      recognizedText,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                GestureDetector(
                  onLongPressStart: (_) => _startListening(),
                  onLongPressEnd: (_) => _stopListening(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isListening ? Colors.green : Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: isListening ? 70 : 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Progress Bar
  Widget _buildProgressBar() {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          double maxWidth = constraints.maxWidth - 20;
          double iconWidth = 25;
          double progress = maxWidth * ((currentPage + 1) / totalPages);
          double iconPos = (progress - iconWidth / 2).clamp(
            0,
            maxWidth - iconWidth,
          );

          return Stack(
            children: [
              Positioned(
                top: 9,
                left: 10,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: progress,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F95E4),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                ),
              ),
              Positioned(
                top: 1,
                left: 10 + iconPos,
                child: Container(
                  width: iconWidth,
                  height: 27,
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
    );
  }

  // Floating Avatar
  Widget _buildFloatingAvatar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, top: 20),
      child: Column(
        children: [
          Container(
            width: 128,
            height: 128,
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
                width: 100,
                height: 106,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/head.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 19),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    77,
                    77,
                    77,
                  ).withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: const CustomPaint(
              size: Size(44, 19),
              painter: _PointerTrianglePainter(),
            ),
          ),
        ],
      ),
    );
  }

  // Question Box
  Widget _buildQuestion() {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(bottom: 32),
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
          fruitPages[currentPage]["question"] as String,
          style: const TextStyle(
            fontFamily: 'Khula',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF805E57),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Fruit Button
  Widget _buildFruitButton({
    required String imagePath,
    required bool isCorrect,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          width: screenWidth * 0.4,
          height: screenHeight * 0.15,
        ),
      ),
    );
  }
}

// Triangle pointer
class _PointerTrianglePainter extends CustomPainter {
  const _PointerTrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
