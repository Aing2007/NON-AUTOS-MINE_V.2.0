import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameH.dart';

class SelectFruit1 extends StatefulWidget {
  const SelectFruit1({Key? key}) : super(key: key);

  @override
  State<SelectFruit1> createState() => _SelectFruit1State();
}

class _SelectFruit1State extends State<SelectFruit1> {
  int score = 0;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_blue.png'),
              fit: BoxFit.cover,
            ),
          ),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Floating Fruit Selector
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
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
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
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "เลือกผลไม้ที่ถูกต้อง",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            buildFruitButton("assets/images/apple.png"),
                            buildFruitButton("assets/images/orange.png"),
                            buildFruitButton("assets/images/banana.png"),
                            buildFruitButton("assets/images/grape.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFruitButton(String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          score += 10;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.black;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
