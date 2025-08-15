import 'package:flutter/material.dart';
import 'gamemap_screen.dart';
import 'start_screen.dart';
import 'profile_screen.dart';

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
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/ICON.png',
                                ), // ✅ รูปภาพของคุณ
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.6,
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

                          const SizedBox(width: 16),
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
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    8,
                                    20,
                                    8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFD370),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.attach_money,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
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
                  right: 24,
                  top: 90,
                  child: Container(
                    width: 53,
                    height: 186,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
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
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
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
                          isActive: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MAINHomePage(
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
                          ),
                        ),
                        _BottomNavButton(
                          icon: Icons.games,
                          label: 'GAME',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameMapScreen(
                                pageColor: pageColor,
                                level: level,
                                testResult: testResult,
                                score1: score1,
                                score2: score2,
                                score3: score3,
                                score4: score4,
                              ),
                            ),
                          ),
                        ),
                        _BottomNavButton(
                          icon: Icons.person,
                          label: 'PROFILE',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardPage(
                                pageColor: pageColor,
                                level: level,
                                testResult: testResult,
                                score1: score1,
                                score2: score2,
                                score3: score3,
                                score4: score4,
                              ),
                            ),
                          ),
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
  final VoidCallback onTap;

  const _SidebarButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

class _BottomNavButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
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
              color: widget.isActive ? Colors.blue : Colors.grey,
              size: 30,
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isActive ? Colors.blue : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
