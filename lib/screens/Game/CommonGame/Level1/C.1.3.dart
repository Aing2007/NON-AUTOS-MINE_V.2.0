import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameC.dart';

class EatFruitGame extends StatefulWidget {
  const EatFruitGame({Key? key}) : super(key: key);

  @override
  State<EatFruitGame> createState() => _EatFruitGameState();
}

class _EatFruitGameState extends State<EatFruitGame> {
  int score = 0;
  int currentPage = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "1.ส่วนไหนของกล้วยที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/banana.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/banana1.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/banana2.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "2.ส่วนไหนของแอปเปิ้ลที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/apple.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/noto-v1_red-apple.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/Group 34004.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "3.ส่วนไหนขององุ่นที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/grab.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/Group 33974.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/Group 34005.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "4.ส่วนไหนของกีวี่ที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/kiwi.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/noto_kiwi-fruit.png",
          "isCorrect": true,
        },
        {
          "image":
              "assets/game_assets/prototype/fruit/noto_kiwi-fruit สำเนา.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "5.ส่วนไหนของสตรอว์เบอร์รีที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/strawberry.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/Group 34006.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/emojione_strawberry.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "6.ส่วนไหนของมะพร้าวที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/coconut.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/twemoji_coconut.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/twemoji_coconut-1.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "7.ส่วนไหนของเลมอนที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/lemon.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/noto_lemon.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/noto_lemon-1.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "8.ส่วนไหนของลูกท้อที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/peach.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/fxemoji_peach.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/fxemoji_peach-1.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "9.ส่วนไหนของสัปปะรดที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/pineapple.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/noto-v1_pineapple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/noto-v1_pineapple-1.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "10.ส่วนไหนของแตงโมที่กินได้",
      "imageFruit": "assets/game_assets/prototype/fruit/watermelon.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/fruit/noto_watermelon-1.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/noto_watermelon.png",
          "isCorrect": false,
        },
      ],
    },
    // TODO: เพิ่มอีก 9 ข้อ
  ];

  late int totalPages = questions.length;

  void _handleAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() => score++);
    }

    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage++;
        TtsService.speak(
          questions[currentPage]["question"] as String,
          rate: 0.5,
          pitch: 1.0,
        );
      });
    } else {
      // จบเกม
      TtsService.speak(
        "คุณทำคะแนนได้ $score จาก $totalPages",
        rate: 0.5,
        pitch: 1.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen_C(
            context: context,
            totalScore: score,
            currentLevel: 1,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[currentPage];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height; // ✅ แก้ไขเพิ่ม

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight, // ✅ ใช้ตัวที่ประกาศแล้ว
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGC.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  // Header
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // Progress Bar + Icon
                  Container(
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

                        return Stack(
                          children: [
                            Positioned(
                              top: 9,
                              left: 10,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: calculateProgress(maxWidth),
                                height: 11,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    228,
                                    197,
                                    73,
                                  ),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              left:
                                  10 +
                                  calculateIconPosition(maxWidth, iconWidth),
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
                  ),

                  // ✅ Floating Fruit Selector
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.2, // responsive
                          height: screenWidth * 0.2,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
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
                              height: screenWidth * 0.16,
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
                        CustomPaint(
                          size: Size(screenWidth * 0.1, screenWidth * 0.05),
                          painter: TrianglePainter(),
                        ),
                      ],
                    ),
                  ),

                  // กล่องคำถาม + ผลไม้
                  SizedBox(
                    height: screenHeight * 0.6,
                    child: Center(
                      child: Container(
                        width: screenWidth * 0.85,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(186, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // ข้อความโจทย์
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                current["question"] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ภาพผลไม้
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Image.asset(
                                  current["imageFruit"] as String,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ตัวเลือก
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: (current["options"] as List).map((opt) {
                                return GestureDetector(
                                  onTap: () =>
                                      _handleAnswer(opt["isCorrect"] as bool),
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        opt["image"] as String,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Helper Functions
  double calculateProgress(double maxWidth) {
    return (currentPage + 1) / totalPages * maxWidth;
  }

  double calculateIconPosition(double maxWidth, double iconWidth) {
    return (currentPage + 1) / totalPages * maxWidth - (iconWidth / 2);
  }
}
