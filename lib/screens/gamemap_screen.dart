import 'package:flutter/material.dart';
import 'main_screen.dart'; // หน้า HOME
import 'profile_screen.dart'; // หน้า PROFILE
import 'package:url_launcher/url_launcher.dart';
import 'Game/LenguageGame/map_L.dart';
import 'Game/SocialGame/map_S.dart';
import 'Game/SenceGame/map_C.dart';
import 'Game/HealthGame/map_H.dart';

void main() {
  runApp(MyApp());
}

/// แอปหลัก เริ่มที่ GameMapScreen
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Design',
      theme: ThemeData(fontFamily: 'Inter'),

      debugShowCheckedModeBanner: false,
    );
  }
}

/// หน้าหลักแสดงวงกลมและไอคอนต่าง ๆ
class GameMapScreen extends StatefulWidget {
  final String? level;
  final String? testResult;
  final Color? pageColor;
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;
  final String? summaryCode;

  const GameMapScreen({
    Key? key,
    this.level,
    this.testResult,
    this.pageColor,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
    this.summaryCode,
  }) : super(key: key);

  @override
  State<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  static const Color creamBackground = Color(0xFFF5F3F0);
  static const Color sageGreen = Color(0xFF8BC5A7); // H
  static const Color goldYellow = Color(0xFFF4C430); // C
  static const Color coralRed = Color(0xFFFF5A5A); // S
  static const Color periwinkleBlue = Color(0xFF5A7CFF); // L
  static const Color mediumGray = Color(0xFF999999);
  static const Color darkGray = Color(0xFF666666);

  /// ฟังก์ชันเปิดแอป Unity
  void _launchUnityApp() async {
    const packageName = 'com.defaultcompany.template.mobile2d';
    final url = 'intent://#Intent;package=$packageName;end';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ไม่พบแอป Unity')));
    }
  }

  /// สร้างวงกลมสีพร้อมไอคอนล็อกหรือไม่ และกำหนด onTap
  Widget _buildColoredCircle(
    Color color, {
    bool locked = false,
    VoidCallback? onTap,
  }) {
    Widget circle = Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 20),
            spreadRadius: -5,
          ),
        ],
      ),
      child: locked
          ? const Icon(Icons.lock_outline, size: 80, color: Colors.white)
          : null,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: circle)
        : circle;
  }

  /// สร้างวงกลมและสามเหลี่ยมตาม summaryCode
  /// สร้างวงกลมเรียงตาม summaryCode ใหม่
  List<Widget> _buildCirclesAndTriangles() {
    // ตรวจสอบ summaryCode ให้ถูกต้อง
    const defaultSummary = 'LSCH';
    final code = widget.summaryCode?.toUpperCase() ?? defaultSummary;

    final validChars = {'L', 'S', 'C', 'H'};
    final codeSet = code.split('').toSet();
    final summary =
        (code.length != 4 ||
            !codeSet.containsAll(validChars) ||
            codeSet.length != 4)
        ? defaultSummary
        : code;

    final colorMap = {
      'L': periwinkleBlue,
      'S': coralRed,
      'C': goldYellow,
      'H': sageGreen,
    };

    List<Widget> widgets = [];

    // วงกลมด้านล่างสุด
    widgets.add(_buildImageCircle());

    // วงกลมสีเรียงจากด้านล่างขึ้นบน
    for (int i = 0; i < summary.length; i++) {
      final ch = summary[i];
      final color = colorMap[ch] ?? Colors.grey;

      final circleWidget = _buildColoredCircle(
        color,
        locked: i != 0, // ตัวแรกไม่มี lock
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                switch (ch) {
                  case 'L':
                    return MAPLscreen();
                  case 'S':
                    return MAPSscreen();
                  case 'C':
                    return MAPCscreen();
                  case 'H':
                    return MAPHscreen();
                  default:
                    return NextScreen(title: 'Unknown Screen');
                }
              },
            ),
          );
        },
      );

      // เพิ่มวงกลมด้านบน image circle
      widgets.insert(1 + i, circleWidget);
      widgets.insert(2 + i, const SizedBox(height: 24)); // เว้นช่องว่าง
    }

    return widgets;
  }

  Widget _buildTriangle(Color color) {
    return CustomPaint(
      size: const Size(20, 10),
      painter: TrianglePainter(color),
    );
  }

  Widget _buildtrianglenormal(Color color) {
    return Transform.rotate(
      angle: 3.1416,
      child: CustomPaint(
        size: const Size(20, 10),
        painter: TrianglePainter(color),
      ),
    );
  }

  Widget _buildImageCircle() {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/head.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/ICON.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.white, width: 2.4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                              spreadRadius: -3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NON AUTOS MINE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: darkGray,
                              ),
                            ),
                            Text(
                              'ระดับ= ${widget.summaryCode ?? "LSCH"}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15,
                                    offset: const Offset(0, 10),
                                    spreadRadius: -3,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      color: goldYellow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '12,000,000.00 points',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: mediumGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                    child: Column(children: _buildCirclesAndTriangles()),
                  ),
                ),
              ],
            ),

            // Bottom Navigation
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomNavButton(
                      icon: Icons.home,
                      label: 'HOME',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MAINHomePage(
                              pageColor: widget.pageColor,
                              level: widget.level,
                              testResult: widget.testResult,
                              score1: widget.score1,
                              score2: widget.score2,
                              score3: widget.score3,
                              score4: widget.score4,
                              summaryCode: widget.summaryCode,
                            ),
                          ),
                        );
                      },
                    ),
                    _BottomNavButton(
                      icon: Icons.games,
                      label: 'GAME',
                      iconColor: Colors.blue,
                      labelColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameMapScreen(
                              pageColor: widget.pageColor,
                              level: widget.level,
                              testResult: widget.testResult,
                              score1: widget.score1,
                              score2: widget.score2,
                              score3: widget.score3,
                              score4: widget.score4,
                              summaryCode: widget.summaryCode,
                            ),
                          ),
                        );
                      },
                    ),
                    _BottomNavButton(
                      icon: Icons.person,
                      label: 'PROFILE',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DashboardPage(
                              pageColor: widget.pageColor,
                              level: widget.level,
                              testResult: widget.testResult,
                              score1: widget.score1,
                              score2: widget.score2,
                              score3: widget.score3,
                              score4: widget.score4,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// วาดสามเหลี่ยมสี
class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// หน้าตัวอย่างถ้าไม่ใช่ MapL/MapS/C/H
class NextScreen extends StatelessWidget {
  final String title;
  const NextScreen({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF5A7CFF),
      ),
      body: Center(
        child: Text(
          'นี่คือหน้าของ $title',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

/// ปุ่มเมนูด้านล่าง
class _BottomNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;
  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? Colors.grey, size: 30),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
