import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../SocialGame/map_S.dart';
import 'package:non_autos_mine/screens/Game/SocialGame/Level1/S.1.2.dart';
import 'package:non_autos_mine/screens/Game/LenguageGame/Level1/L.1.3.dart';

Widget buildSummaryScreen_S({
  required BuildContext context,
  required int totalScore,
  required int currentLevel,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  // ✅ ใช้ scaleFactor สำหรับ responsive
  double baseWidth = 390;
  double scale = screenWidth / baseWidth;

  int scoreValue = totalScore * 10;

  int calculateStars(int score) {
    if (score >= 71) return 3;
    if (score >= 36) return 2;
    if (score >= 10) return 1;
    return 0;
  }

  int starsEarned = calculateStars(scoreValue);

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/GameBG/StartBGS.png"),
          fit: BoxFit.cover, // ✅ ให้ภาพเต็มหน้าจอ
        ),
      ),
      child: SafeArea(
        // ✅ ย้าย SafeArea มาห่อ child ตรงนี้
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            margin: EdgeInsets.symmetric(horizontal: 16 * scale),
            padding: EdgeInsets.symmetric(
              vertical: 12 * scale,
              horizontal: 16 * scale,
            ),
            child: Column(
              children: [
                // ===== Header =====
                GameHeader(
                  money: "12,000,000.00",
                  profileImage: "assets/images/head.png",
                ),
                SizedBox(height: 20 * scale),

                // ===== Progress Bar =====
                Container(
                  width: double.infinity,
                  height: 30 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
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
                      double iconWidth = 28 * scale;

                      return Stack(
                        children: [
                          Positioned(
                            top: 11 * scale,
                            left: 10,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: maxWidth,
                              height: 8 * scale,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF65A3B),
                                borderRadius: BorderRadius.circular(8 * scale),
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
                              height: 28 * scale,
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
                  margin: EdgeInsets.symmetric(vertical: 24 * scale),
                  child: Column(
                    children: [
                      Container(
                        width: 120 * scale,
                        height: 120 * scale,
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
                            width: 90 * scale,
                            height: 90 * scale,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/head.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12 * scale),
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
                          size: Size(40 * scale, 14 * scale),
                          painter: TrianglePainter(),
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Stars & Score Box =====
                Container(
                  width: double.infinity,
                  height: 180 * scale,
                  margin: EdgeInsets.only(bottom: 24 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20 * scale),
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
                              horizontal: 8 * scale,
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              size: 60 * scale,
                              color: index < starsEarned
                                  ? const Color(0xFFF65A3B)
                                  : Colors.grey[400],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 12 * scale),

                      // 📦 Score Box
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * scale,
                          vertical: 8 * scale,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF65A3B),
                          borderRadius: BorderRadius.circular(30 * scale),
                        ),
                        child: Text(
                          "คะแนน $totalScore / 10",
                          style: TextStyle(
                            fontSize: 18 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Buttons Row =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MAPSscreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(20 * scale),
                        child: Container(
                          height: 55 * scale,
                          margin: EdgeInsets.symmetric(horizontal: 8 * scale),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20 * scale),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.location_pin,
                              color: const Color(0xFFF65A3B),
                              size: 36 * scale,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (currentLevel == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectFruitDragGame(),
                              ),
                            );
                          } else if (currentLevel == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SelectFruit3(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("ยังไม่มีด่านถัดไปนะครับ 🙂"),
                              ),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(20 * scale),
                        child: Container(
                          height: 55 * scale,
                          margin: EdgeInsets.symmetric(horizontal: 8 * scale),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20 * scale),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: const Color(0xFFF65A3B),
                              size: 36 * scale,
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
