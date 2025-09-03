import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameL.dart';
import '../../../../AIfunction/STT.dart';
import 'package:non_autos_mine/screens/Game/LenguageGame/Level1/L.1.1.dart';

class SelectFruit3 extends StatefulWidget {
  const SelectFruit3({Key? key}) : super(key: key);

  @override
  State<SelectFruit3> createState() => _SelectFruitState();
}

class _SelectFruitState extends State<SelectFruit3> {
  int score = 0;
  int currentPage = 0;
  String recognizedText = ""; // ✅ เก็บข้อความจาก Speech

  final List<Map<String, dynamic>> fruitPages = [
    {
      //==========================================1==================================================
      "question": "1.ฉันชอบกินกล้วย",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================2==================================================
    {
      "question": "2.ฉันชอบกินแอปเปิ้ล",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================3==================================================
    {
      "question": "3.ฉันชอบกินองุ่น",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": true,
        },
      ],
    },
    //==========================================4==================================================
    {
      "question": "4.ฉันชอบกินกีวี่",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================5==================================================
    {
      "question": "5.ฉันกินสตรอเบอร์รี่",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================6==================================================
    {
      "question": "6.ฉันกินมะพร้าว",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },

        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": true,
        },
      ],
    },
    //==========================================7==================================================
    {
      "question": "7.ฉันกินเลม่อน",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================8==================================================
    {
      "question": "8.ฉันกินลูกท้อ",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },

        {
          "image": "assets/game_assets/prototype/fruit/peach.png",
          "isCorrect": true,
        },
      ],
    },
    //==========================================9==================================================
    {
      "question": "9.ฉันกินสับปะรด",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
          "isCorrect": true,
        },
      ],
    },
    //==========================================10==================================================
    {
      "question": "10.ฉันกินแตงโม",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/watermelon.png",
          "isCorrect": true,
        },

        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
      ],
    },
  ];

  late int totalPages = fruitPages.length;

  @override
  void initState() {
    super.initState();
    TtsService.speak(
      fruitPages[0]["question"] as String,
      rate: 0.5,
      pitch: 1.0,
    );
  }

  // ฟังก์ชันคำนวณความยาว ProgressBar
  double calculateProgress(double maxWidth) {
    return maxWidth * ((currentPage + 1) / totalPages);
  }

  // ฟังก์ชันคำนวณตำแหน่ง icon บน ProgressBar
  double calculateIconPosition(double maxWidth, double iconWidth) {
    double progress = calculateProgress(maxWidth);
    // ไม่ให้ icon หลุดขอบขวา
    return (progress - iconWidth / 2).clamp(0, maxWidth - iconWidth);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // ✅ พื้นหลัง + เนื้อหาเกม
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

                      // ✅ Progress Bar (เหมือนเดิม)
                      _buildProgressBar(),

                      // ✅ Floating Fruit Selector
                      _buildFloatingAvatar(),

                      // ✅ Question
                      _buildQuestion(),

                      // ✅ Fruits
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

                      SizedBox(
                        height: screenHeight * 0.15,
                      ), // กันไม่ให้บังปุ่มไมค์
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ✅ ปุ่มไมโครโฟน + แสดงข้อความที่ฟังได้
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
                  onLongPressStart: (_) async {
                    await SpeechService.startListening((text) {
                      setState(() => recognizedText = text);
                    });
                  },
                  onLongPressEnd: (_) async {
                    await SpeechService.stopListening();
                  },
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ แยก widget ย่อยเพื่อความเป็นระเบียบ
  // ✅ Progress Bar
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
          double maxWidth = constraints.maxWidth - 20; // padding ซ้ายขวา
          double iconWidth = 25;

          return Stack(
            children: [
              // Progress indicator
              Positioned(
                top: 9,
                left: 10,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: calculateProgress(maxWidth),
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F95E4),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                ),
              ),

              // Progress icon
              Positioned(
                top: 1,
                left: 10 + calculateIconPosition(maxWidth, iconWidth),
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

  // ✅ Floating Avatar
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
            child: CustomPaint(
              size: const Size(44, 19),
              painter: const _PointerTrianglePainter(), // ⬅️ ใช้ชื่อใหม่
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Question Box
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

  // ✅ Fruit Button
  Widget _buildFruitButton({
    required String imagePath,
    required bool isCorrect,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        // เพิ่มคะแนนถ้าถูก
        if (isCorrect) {
          setState(() {
            score += 1;
          });
        }

        // ไปหน้าผลไม้ชุดถัดไป
        setState(() {
          if (currentPage < fruitPages.length - 1) {
            currentPage += 1; // ขึ้นชุดต่อไป
            print("Current Score: $score");
            TtsService.speak(
              fruitPages[currentPage]["question"] as String,
              rate: 0.5,
              pitch: 1.0,
            );
          } else {
            // ถ้าเป็นหน้าสุดท้าย แสดงผลลัพธ์
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
                ),
              ),
            );
          }
        });
      },
      child: Container(
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
      ),
    );
  }
}

class _PointerTrianglePainter extends CustomPainter {
  const _PointerTrianglePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height); // bottom center
    path.lineTo(0, 0); // top left
    path.lineTo(size.width, 0); // top right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
