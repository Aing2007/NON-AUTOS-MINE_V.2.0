import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameL.dart';

class SelectFruit1 extends StatefulWidget {
  const SelectFruit1({Key? key}) : super(key: key);

  @override
  State<SelectFruit1> createState() => _SelectFruitState();
}

class _SelectFruitState extends State<SelectFruit1> {
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
  @override
  void initState() {
    super.initState();
    // ✅ อ่านคำถามแรกทันทีเมื่อเข้าสู่หน้า
    TtsService.speak(
      fruitPages[0]["question"] as String,
      rate: 0.5,
      pitch: 1.0,
    );
  }

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
        if (isCorrect) {
          setState(() => score += 1);
        }

        setState(() {
          if (currentPage < fruitPages.length - 1) {
            currentPage += 1;
            TtsService.speak(
              fruitPages[currentPage]["question"] as String,
              rate: 0.5,
              pitch: 1.0,
            );
          } else {
            TtsService.speak(
              "คุณทำคะแนนได้ $score คะแนน จากทั้งหมด $totalPages คะแนน",
              rate: 0.5,
              pitch: 1.0,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => buildSummaryScreen_L(
                  context: context,
                  totalScore: score,
                  currentLevel: 1,
                ),
              ),
            );
          }
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: SizedBox(
          width: 30,
          height: 30,
          // ✅ บังคับให้เป็นสี่เหลี่ยม
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
            child: Padding(
              padding: const EdgeInsets.all(8.0), // กันภาพชนขอบ
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGL.png'),
            fit: BoxFit.cover, // <-- สำคัญมาก จะทำให้เต็มจอ
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // ✅ Progress Bar
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
                                  color: const Color(0xFF7F95E4),
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
                          width: screenWidth * 0.3, // responsive
                          height: screenWidth * 0.3,
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
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.26,
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

                  // ✅ Question Filter Bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
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
                        style: TextStyle(
                          fontFamily: 'Khula',
                          fontSize: screenWidth * 0.05, // responsive font
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF805E57),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // ✅ Fruit Selection Grid
                  // ✅ Fruit Selection Grid (fix 2x2 always)
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2, // บังคับให้ 2 เสมอ
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5, // ✅ ทำให้ปุ่มเป็นสี่เหลี่ยมจัตุรัส
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
