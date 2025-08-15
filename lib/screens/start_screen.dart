import 'package:flutter/material.dart';
import '../widgets/backwordbutton-loginpage.dart';
import 'main_screen.dart'; // หน้าที่จะนำทางไป

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 ภาพพื้นหลังเต็มจอ
          Positioned.fill(
            child: Image.asset('assets/images/WELCOME1.png', fit: BoxFit.cover),
          ),

          // 🔹 ปุ่ม Back ด้านบนซ้าย
          Positioned(
            top: mediaQuery.padding.top + 16,
            left: 16,
            child: const BackButtonWidget(),
          ),

          // 🔹 ปุ่ม START ล่างสุดของจอ
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: _StartButton(screenHeight: screenHeight),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ ปุ่ม START ทำให้ responsive
class _StartButton extends StatefulWidget {
  final double screenHeight;
  const _StartButton({Key? key, required this.screenHeight}) : super(key: key);

  @override
  State<_StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<_StartButton> {
  bool _isPressed = false;
  bool _isNavigating = false;

  void _goToNextPage() async {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MAINHomePage()),
    );

    setState(() => _isNavigating = false);
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.screenHeight;
    final isSmallScreen = height < 600;

    return Container(
      height: height * 0.12, // 12% ของความสูงจอ
      decoration: const BoxDecoration(
        color: Color(0xFF8BC7AD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 0)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: _goToNextPage,
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'START',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Barlow Semi Condensed',
                fontSize: isSmallScreen ? 32 : 60,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFFAF5EF),
                letterSpacing: 2.4,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 0),
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
