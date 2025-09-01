import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';

class SelectFruit extends StatefulWidget {
  const SelectFruit({Key? key}) : super(key: key);

  @override
  State<SelectFruit> createState() => _SelectFruitState();
}

class _SelectFruitState extends State<SelectFruit> {
  int score = 0;
  int currentPage = 0;

  // List ของผลไม้แต่ละชุด (แต่ละหน้ามี 4 ผลไม้)
  final List<List<Map<String, dynamic>>> fruitPages = [
    [
      {"image": "assets/images/banana.png", "isCorrect": true},
      {"image": "assets/images/apple.png", "isCorrect": false},
      {"image": "assets/images/mango.png", "isCorrect": true},
      {"image": "assets/images/lemon.png", "isCorrect": false},
    ],
    [
      {"image": "assets/images/strawberry.png", "isCorrect": true},
      {"image": "assets/images/kiwi.png", "isCorrect": false},
      {"image": "assets/images/pineapple.png", "isCorrect": true},
      {"image": "assets/images/grape.png", "isCorrect": false},
    ],
    // เพิ่มชุดต่อไปได้ตามต้องการ
  ];

  late int totalPages = fruitPages.length;
  double getProgressWidth(double maxWidth) {
    return maxWidth * ((currentPage + 1) / totalPages);
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
          } else {
            // ถ้าเป็นหน้าสุดท้าย อาจจะแสดง dialog หรือ reset
            print("Game Finished! Score: $score");
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
                    child: Stack(
                      children: [
                        // Progress indicator
                        Positioned(
                          top: 9,
                          left: 19,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: getProgressWidth(
                              MediaQuery.of(context).size.width - 400,
                            ), // ลบ padding/offset
                            height: 11,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7F95E4),
                              borderRadius: BorderRadius.circular(5.5),
                            ),
                          ),
                        ),
                        // Progress icon (optional)
                        Positioned(
                          top: 1,
                          left: getProgressWidth(
                            MediaQuery.of(context).size.width - 390,
                          ),
                          child: Container(
                            width: 25,
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
                    child: const Center(
                      child: Text(
                        'ผลไม้ที่มีสีเหลือง',
                        style: TextStyle(
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
                    children: List.generate(fruitPages[currentPage].length, (
                      index,
                    ) {
                      final fruit = fruitPages[currentPage][index];
                      return _buildFruitButton(
                        imagePath: fruit["image"],
                        isCorrect: fruit["isCorrect"],
                      );
                    }),
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
