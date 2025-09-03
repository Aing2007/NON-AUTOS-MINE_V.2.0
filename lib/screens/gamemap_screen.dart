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
    required double circleSize,
    required double iconSize,
  }) {
    Widget circle = Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: circleSize * 0.027),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: circleSize * 0.17,
            offset: Offset(0, circleSize * 0.13),
            spreadRadius: -circleSize * 0.03,
          ),
        ],
      ),
      child: locked
          ? Icon(Icons.lock_outline, size: iconSize, color: Colors.white)
          : null,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: circle)
        : circle;
  }

  /// สร้างวงกลมและสามเหลี่ยมตาม summaryCode
  /// สร้างวงกลมเรียงตาม summaryCode ใหม่
  /// สร้างวงกลมและสามเหลี่ยมตาม summaryCode
  /// สร้างวงกลมและสามเหลี่ยมตาม summaryCode
  List<Widget> _buildCirclesAndTriangles(
    double circleSize,
    double iconSize,
    double imageCircleSize,
    double triangleHeight,
    double triangleWidth,
    double gap,
  ) {
    // ตรวจสอบ summaryCode
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

    final summaryList = summary.split(''); // ไม่ reverse

    for (int i = 0; i < summaryList.length; i++) {
      final ch = summaryList[i];
      final color = colorMap[ch] ?? Colors.grey;

      // ตัวบนสุดปลดล็อก
      bool isUnlocked = (i == 0);

      widgets.add(
        _buildColoredCircle(
          color,
          locked: !isUnlocked,
          onTap: () {
            if (isUnlocked) {
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
            }
          },
          circleSize: circleSize,
          iconSize: iconSize,
        ),
      );

      widgets.add(SizedBox(height: gap));

      // วางสามเหลี่ยมระหว่างวงกลม (ยกเว้นวงกลมสุดท้าย)
      if (i < summaryList.length - 1) {
        widgets.add(_buildtrianglenormal(color, triangleWidth, triangleHeight));
        widgets.add(SizedBox(height: gap));
      }
    }
    // ปิดท้ายด้วยไอคอนรูปภาพด้านบน พร้อมเว้นระยะห่าง
    widgets.insert(
      0,
      SizedBox(height: gap * 0.5),
    ); // เว้นระยะห่างระหว่างสามเหลี่ยมกับวงกลม
    widgets.insert(
      0,
      _buildTriangle(Colors.grey, triangleWidth, triangleHeight),
    );
    widgets.insert(0, _buildImageCircle(imageCircleSize, gap));

    return widgets;
  }

  Widget _buildTriangle(Color color, double width, double height) {
    return CustomPaint(
      size: Size(width, height),
      painter: TrianglePainter(color),
    );
  }

  Widget _buildtrianglenormal(Color color, double width, double height) {
    // หัวชี้ขึ้น
    return CustomPaint(
      size: Size(width, height),
      painter: TrianglePainter(color),
    );
  }

  Widget _buildImageCircle(double size, double gap) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: size * 0.044),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: size * 0.17,
                offset: Offset(0, size * 0.11),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/head.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: gap * 0.33),
        SizedBox(height: gap),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double horizontalPadding = width * 0.06;
    final double verticalPadding = height * 0.025;
    final double avatarSize = width * 0.18;
    final double imageCircleSize = width * 0.24;
    final double circleSize = width * 0.36;
    final double iconSize = width * 0.18;
    final double triangleHeight = width * 0.06;
    final double triangleWidth = width * 0.11;
    final double gap = height * 0.04;
    final double bottomBarHeight = height * 0.10;
    final double bottomBarRadius = width * 0.07;
    final double navIconSize = width * 0.08;
    final double navFontSize = width * 0.035;

    return Scaffold(
      backgroundColor: creamBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                verticalPadding * 0.5,
                horizontalPadding,
                verticalPadding * 0.9,
              ),
              child: Row(
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ICON.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.white,
                        width: avatarSize * 0.033,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: avatarSize * 0.21,
                          offset: Offset(0, avatarSize * 0.14),
                          spreadRadius: -avatarSize * 0.04,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: horizontalPadding * 0.5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NON AUTOS MINE',
                          style: TextStyle(
                            fontSize: navFontSize * 1.2,
                            fontWeight: FontWeight.w600,
                            color: darkGray,
                          ),
                        ),

                        SizedBox(height: verticalPadding * 0.1),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 1.2,
                            vertical: verticalPadding * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: Offset(0, 10),
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: navIconSize * 1.1,
                                height: navIconSize * 1.1,
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
                              SizedBox(width: horizontalPadding * 0.7),
                              Text(
                                '12,000,000.00 points',
                                style: TextStyle(
                                  fontSize: navFontSize * 1.3,
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
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  bottomBarHeight * 1.2,
                ),
                child: Column(
                  children: _buildCirclesAndTriangles(
                    circleSize,
                    iconSize,
                    imageCircleSize,
                    triangleHeight,
                    triangleWidth,
                    gap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(bottomBarRadius * 2.2),
            topRight: Radius.circular(bottomBarRadius * 2.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, -5),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding * 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavButton(
              icon: Icons.home,
              label: 'HOME',
              iconSize: navIconSize,
              fontSize: navFontSize,
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
              iconSize: navIconSize,
              fontSize: navFontSize,
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
              iconSize: navIconSize,
              fontSize: navFontSize,
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
  final double? iconSize;
  final double? fontSize;
  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? Colors.grey, size: iconSize ?? 30),
          SizedBox(height: (fontSize ?? 12) * 0.33),
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.grey,
              fontSize: fontSize ?? 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
