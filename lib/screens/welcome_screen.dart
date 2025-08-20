import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login+signup/login_screen.dart';
import 'Login+signup/signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.04;
    final double horizontalPadding = size.width * 0.04;
    final double welcomeFontSize = size.width * 0.075;
    final double descFontSize = size.width * 0.035;
    final double buttonWidth = size.width * 0.38;
    final double buttonHeight = size.height * 0.09;

    return Scaffold(
      body: Container(
        // Set background image for the welcome screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/WELCOME1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Height for the yellow curved background
            final double curveHeight = constraints.maxHeight * 0.32;
            return Stack(
              children: [
                // --- Yellow curved background at the bottom ---
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: curveHeight*1.1,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2D37D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                      ),
                    ),
                  ),
                ),
                // --- Main content: Texts and Buttons ---
                Positioned(
                  left: 0,
                  right: 0,
                  // Move the content further down by increasing 'bottom'
                  top: curveHeight*1.7,// Move text down
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.95,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        verticalPadding * 2,
                        horizontalPadding,
                        verticalPadding * 2,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: verticalPadding),
                          // --- Welcome Title ---
                          Text(
                            'ยินดีต้อนรับ',
                            style: GoogleFonts.barlowSemiCondensed(
                              fontSize: welcomeFontSize,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              height: 1.0,
                              color: const Color(0xFF705048),
                            ),
                          ),
                          SizedBox(height: verticalPadding / 3),
                          // --- Description ---
                          Text(
                            'ยินดีต้อนรับสู่ "NON-AUTOS MINE แอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n(ระยะที่ 1 และ 2) อย่างครบวงจร',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.barlowSemiCondensed(
                              fontSize: descFontSize,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              height: 1.4,
                              color: const Color(0xFF7F6157),
                            ),
                          ),
                          SizedBox(height: verticalPadding),
                          // --- Login and Signup Buttons ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // --- Login Button ---
                              SizedBox(
                                width: buttonWidth,
                                height: buttonHeight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF705048),
                                    foregroundColor: const Color(0xFFFFFBF0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'LOG IN',
                                    style: GoogleFonts.barlowSemiCondensed(
                                      fontSize: descFontSize,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: horizontalPadding),
                              // --- Signup Button ---
                              SizedBox(
                                width: buttonWidth,
                                height: buttonHeight,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInScreen(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFFBF0),
                                    foregroundColor: const Color(0xFF705048),
                                    side: const BorderSide(
                                      color: Color(0xFF705048),
                                      width: 1.6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                  ),
                                  child: Text(
                                    'SIGN UP',
                                    style: GoogleFonts.barlowSemiCondensed(
                                      fontSize: descFontSize,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
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
              ],
            );
          },
        ),
      ),
    );
  }
}