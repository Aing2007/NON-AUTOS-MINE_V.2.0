import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../LenguageGame/map_L.dart';
import 'package:non_autos_mine/screens/Game/LenguageGame/Level1/L.1.2.dart';
import 'package:non_autos_mine/screens/Game/LenguageGame/Level1/L.1.3.dart';

// ฟังก์ชันสร้างหน้าสรุปผล
Widget buildSummaryScreen({
  required BuildContext context,
  required int totalScore,
  required int currentLevel,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  int scoreValue = totalScore * 10;

  int calculateStars(int score) {
    if (score >= 71) return 3;
    if (score >= 36) return 2;
    if (score >= 10) return 1;
    return 0;
  }

  int starsEarned = calculateStars(scoreValue);

  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Container(
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
            height: screenHeight,
            constraints: const BoxConstraints(maxWidth: 384),
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.04,
            ),
            child: Column(
              children: [
                // ===== Header =====
                GameHeader(
                  money: "12,000,000.00",
                  profileImage: "assets/images/head.png",
                ),
                SizedBox(height: screenHeight * 0.02),

                // ===== Progress Bar =====
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenHeight * 0.02),
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
                      double iconWidth = screenWidth * 0.07;

                      return Stack(
                        children: [
                          Positioned(
                            top: screenHeight * 0.012,
                            left: 10,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: maxWidth, // เต็ม progress
                              height: screenHeight * 0.015,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7F95E4),
                                borderRadius: BorderRadius.circular(
                                  screenHeight * 0.01,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            left:
                                10 +
                                (maxWidth - iconWidth / 2).clamp(
                                  0,
                                  maxWidth - iconWidth,
                                ),
                            child: Container(
                              width: iconWidth,
                              height: screenHeight * 0.035,
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

                // ===== Floating Circle Avatar =====
                Container(
                  margin: EdgeInsets.only(
                    bottom: screenHeight * 0.04,
                    top: screenHeight * 0.025,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: screenWidth * 0.28,
                            height: screenWidth * 0.3,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/head.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          size: Size(screenWidth * 0.12, screenHeight * 0.025),
                          painter: TrianglePainter(),
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Stars & Score Box =====
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.28,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.04),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ⭐ Stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              size: screenWidth * 0.18,
                              color: index < starsEarned
                                  ? const Color(0xFF7F95E4)
                                  : Colors.grey[400],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // 📦 Score Box
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7F95E4),
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.08,
                          ),
                        ),
                        child: Text(
                          "คะแนน $totalScore / 10",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Buttons Row =====
                // ===== Buttons Row =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // กลับไปแผนที่
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MAPLscreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        child: Container(
                          height: screenHeight * 0.08,
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.05,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.location_pin,
                              color: const Color(0xFF7F95E4),
                              size: screenWidth * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (currentLevel == 1) {
                            // ถ้าอยู่ level 1 → ไป SelectFruit2
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectFruit2(),
                              ),
                            );
                          }
                          if (currentLevel == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectFruit3(),
                              ),
                            );
                          } else {
                            // level อื่น ๆ → จะไปหน้าถัดไป หรือให้แสดง Dialog ก็ได้
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("ยังไม่มีด่านถัดไปนะครับ 🙂"),
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        child: Container(
                          height: screenHeight * 0.08,
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.05,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: const Color(0xFF7F95E4),
                              size: screenWidth * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ===== Triangle Painter =====
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
