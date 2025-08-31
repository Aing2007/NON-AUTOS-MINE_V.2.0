import 'package:flutter/material.dart';
import 'gamemap_screen.dart';
import 'start_screen.dart';
import 'profile_screen.dart';
import 'package:non_autos_mine/functionDatabase/database_service.dart';
class MAINHomePage extends StatelessWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;
  final String? level;
  final String? testResult;
  final Color? pageColor;
  final String? summaryCode;
  const MAINHomePage({
    Key? key,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
    this.level,
    this.testResult,
    this.pageColor,
    this.summaryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double horizontalPadding = width * 0.06;
    final double verticalPadding = height * 0.025;
    final double avatarSize = width * 0.22;
    final double sidebarWidth = width * 0.14;
    final double sidebarHeight = height * 0.28;
    final double sidebarButtonSize = width * 0.09;
    final double bottomBarHeight = height * 0.10;
    final double bottomBarRadius = width * 0.07;
    final double iconSize = width * 0.08;
    final double navFontSize = width * 0.035;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/HOME.png', fit: BoxFit.cover),
          ),
          SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        verticalPadding * 2,
                        horizontalPadding,
                        verticalPadding * 2,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: avatarSize,
                            height: avatarSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/ICON.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: horizontalPadding * 0.7),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'SUTINAN SRIVISET',
                                  style: TextStyle(
                                    color: Color(0xFF5F4A46),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.35,
                                    fontFamily: 'Khula',
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: verticalPadding * 0.3),
                                  padding: EdgeInsets.fromLTRB(
                                    horizontalPadding * 0.7,
                                    verticalPadding * 0.7,
                                    horizontalPadding * 1.2,
                                    verticalPadding * 0.7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: sidebarButtonSize * 0.6,
                                        height: sidebarButtonSize * 0.6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFD370),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.attach_money,
                                          color: Colors.white,
                                          size: iconSize * 0.5,
                                        ),
                                      ),
                                      SizedBox(width: horizontalPadding * 0.5),
                                      const Text(
                                        '12,000,000.00',
                                        style: TextStyle(
                                          color: Color(0xFF9C8A87),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Khula',
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
                    const Spacer(),
                  ],
                ),
                Positioned(
                  right: horizontalPadding,
                  top: avatarSize*1.5 ,
                  child: Container(
                    width: sidebarWidth,
                    height: sidebarHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(sidebarWidth * 0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _SidebarButton(
                          icon: Icons.settings,
                          backgroundColor: const Color(0x1A5F4A46),
                          iconColor: const Color(0xFF5F4A46),
                          iconSize: iconSize * 0.7,
                          size: sidebarButtonSize,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                          ),
                        ),
                        _SidebarButton(
                          icon: Icons.mail,
                          backgroundColor: const Color(0x33FED371),
                          iconColor: const Color(0xFFFED371),
                          iconSize: iconSize * 0.7,
                          size: sidebarButtonSize,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                          ),
                        ),
                        _SidebarButton(
                          icon: Icons.store,
                          backgroundColor: const Color(0x337F95E4),
                          iconColor: const Color(0xFF7F95E4),
                          iconSize: iconSize * 0.7,
                          size: sidebarButtonSize,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                          ),
                        ),
                        _SidebarButton(
                          icon: Icons.folder,
                          backgroundColor: const Color(0x33F65A3B),
                          iconColor: const Color(0xFFF65A3B),
                          iconSize: iconSize * 0.7,
                          size: sidebarButtonSize,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: bottomBarHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(bottomBarRadius * 2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
  _BottomNavButton(
    icon: Icons.home,
    label: 'HOME',
        iconColor: Colors.blue,    // ✅ ใช้งานสี custom
    labelColor: Colors.blue, 
    iconSize: iconSize,
    fontSize: navFontSize,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MAINHomePage(
            pageColor: pageColor,
            level: level,
            testResult: testResult,
            score1: score1,
            score2: score2,
            score3: score3,
            score4: score4,
            summaryCode: summaryCode,
          ),
        ),
      );
    },
  ),
  _BottomNavButton(
    icon: Icons.games,
    label: 'GAME',
    // ✅ ใช้งานสี custom
    iconSize: iconSize,
    fontSize: navFontSize,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GameMapScreen(
            pageColor: pageColor,
            level: level,
            testResult: testResult,
            score1: score1,
            score2: score2,
            score3: score3,
            score4: score4,
            summaryCode: summaryCode,
          ),
        ),
      );
    },
  ),
  _BottomNavButton(
    icon: Icons.person,
    label: 'PROFILE',
    iconSize: iconSize,
    fontSize: navFontSize,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(
            pageColor: pageColor,
            level: level,
            testResult: testResult,
            score1: score1,
            score2: score2,
            score3: score3,
            score4: score4,
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
        ],
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final double size;
  final VoidCallback onTap;

  const _SidebarButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.iconSize,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size * 0.28),
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}

class _BottomNavButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final double fontSize;
  final VoidCallback onTap;
  final Color? iconColor;   // ✅ เพิ่ม
  final Color? labelColor;  // ✅ เพิ่ม

  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.iconSize,
    required this.fontSize,
    required this.onTap,
    this.iconColor,   // ✅ เพิ่ม
    this.labelColor,  // ✅ เพิ่ม
  }) : super(key: key);

  @override
  State<_BottomNavButton> createState() => _BottomNavButtonState();
}

class _BottomNavButtonState extends State<_BottomNavButton> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.9);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.iconColor ?? Colors.grey,  // ✅ ใช้สีที่ส่งมา
              size: widget.iconSize,
            ),
            SizedBox(height: widget.fontSize * 0.3),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.labelColor ?? Colors.grey, // ✅ ใช้สีที่ส่งมา
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

