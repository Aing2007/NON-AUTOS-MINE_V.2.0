import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/backwordbutton-loginpage.dart';
import '../../widgets/SocialLoginButton.dart';
import '/utils/colors.dart';
import '../start_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                horizontal: 24.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtonWidget(top: 16, left: 16),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'LOG IN',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownPrimary,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'ยินดีต้อนรับกลับ เราคือแอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.8,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    'โปรดกรอกข้อมูลเพื่อเข้าสู่ระบบ',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.8,
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                          horizontal: 24,
                          vertical: 150,
                        ), // <-- ปรับตรงนี้
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StartScreen(),
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
                                fontSize: 20,
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
                      Row(),
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
