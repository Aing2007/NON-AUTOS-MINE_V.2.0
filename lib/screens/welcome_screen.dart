import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login+signup/login_screen.dart';
import 'Login+signup/signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/WELCOME1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Yellow curved background
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 870,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2D37D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
              ),
            ),

            // เนื้อหา (ข้อความ + ปุ่ม)
            Positioned(
              left: 0,
              right: 0,
              top: 880, // ปรับตำแหน่งให้พอดี
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 655),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Welcome Text
                      Text(
                        'ยินดีต้อนรับ',
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: 55,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          height: 1.0,
                          color: const Color(0xFF705048), // Brown dark
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ยินดีต้อนรับสู่ "NON-Autos mine แอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n(ระยะที่ 1 และ 2) อย่างครบวงจร',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          height: 1.4,
                          color: const Color(0xFF7F6157), // Brown medium
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Button Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Log in
                          SizedBox(
                            width: 288,
                            height: 84,
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Sign in
                          SizedBox(
                            width: 288,
                            height: 84,
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
                                  fontSize: 22,
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
        ),
      ),
    );
  }
}
