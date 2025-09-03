import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../../AIfunction/TTS.dart';
import '../../summaryGameL.dart';

class SelectFruit extends StatefulWidget {
  const SelectFruit({Key? key}) : super(key: key);

  @override
  State<SelectFruit> createState() => _SelectFruitState();
}

class _SelectFruitState extends State<SelectFruit> {
  int score = 0;
  int currentPage = 0;

  // List ของผลไม้แต่ละชุด (แต่ละหน้ามี 4 ผลไม้)
  final List<Map<String, dynamic>> fruitPages = [
    {
      //==========================================1==================================================
      "question": "1.ผลไม้ที่มีสีเหลือง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================2==================================================
    {
      "question": "2.ผลไม้ที่มีสีแดง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================3==================================================
    {
      "question": "3.ผลไม้ที่มีสีม่วง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================4==================================================
    {
      "question": "4.ผลไม้ที่มีสีเขียว",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/peach.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": true,
        },
      ],
    },
    //==========================================5==================================================
    {
      "question": "5.ผลไม้ที่มีสีแดง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================6==================================================
    {
      "question": "6.ผลไม้ที่มีสีน้ำตาล",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/peach.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================7==================================================
    {
      "question": "7.ผลไม้ที่มีสีเหลือง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================8==================================================
    {
      "question": "8.ผลไม้ที่มีสีชมพู",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
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
      "question": "9.ผลไม้ที่มีสีเหลือง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },
      ],
    },
    //==========================================10==================================================
    {
      "question": "10.ผลไม้ที่มีสีแดง",
      "fruits": [
        {
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/watermelon.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
      ],
    },
  ];

  late int totalPages = fruitPages.length;
  double getProgressWidth(double maxWidth) {
    return maxWidth * ((currentPage + 1) / totalPages);
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

  // ฟังก์ชันสร้างปุ่มผลไม้ และรับค่าถูกผิด
  Widget _buildFruitButton({
    required String imagePath,
    required bool isCorrect,
  }) {
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
            // ถ้าเป็นหน้าสุดท้าย อาจจะแสดง dialog หรือ reset
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
                  currentLevel: 1,

                  //onNextLevel: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (_) => NextLevelScreen()),
                  //      },
                ),
              ),
            );
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // สามารถเปลี่ยน background ได้ตรงนี้
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGL.png'), // พื้นหลัง
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 384),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // Progress Bar (เหมือนเดิม)
                  // Progress Bar
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
                        double maxWidth =
                            constraints.maxWidth - 20; // padding ซ้ายขวา
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

                  // Floating Fruit Selector (เหมือนเดิม)
                  Container(
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
                            painter: TrianglePainter(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Filter Bar
                  Container(
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
                  ),

                  // Fruit Selection Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: List.generate(
                      (fruitPages[currentPage]["fruits"] as List).length,
                      (index) {
                        final fruit = fruitPages[currentPage]["fruits"][index];
                        return _buildFruitButton(
                          imagePath: fruit["image"] as String,
                          isCorrect: fruit["isCorrect"] as bool,
                        );
                      },
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
}

// Dropdown triangle
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height); // Bottom center
    path.lineTo(0, 0); // Top left
    path.lineTo(size.width, 0); // Top right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
