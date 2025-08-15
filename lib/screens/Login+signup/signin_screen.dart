import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/backwordbutton-loginpage.dart';
import '../../widgets/SocialLoginButton.dart';
import '/utils/colors.dart';
import '../Test/ATEC_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.yellowPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section with Back Button and Title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtonWidget(top: 16, left: 10),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'SIGN UP',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownPrimary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'สวัสดี\nเราคือแอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.5,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    'โปรดตั้งค่าชื่อผู้ใช้ และรหัสผ่าน',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Card
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(32, 64, 32, 32),
                  child: Column(
                    children: [
                      // Username
                      TextField(
                        controller: _usernameController,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ชื่อผู้ใช้',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ยืนยันรหัสผ่าน',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Login Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 50,
                        ), // <-- ปรับตรงนี้
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ATECHomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brownPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'เข้าสู่ระบบ',
                              style: GoogleFonts.barlowSemiCondensed(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Divider
                      const SizedBox(height: 24),

                      // Social Login
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
