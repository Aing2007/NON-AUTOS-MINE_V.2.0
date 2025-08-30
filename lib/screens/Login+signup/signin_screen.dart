import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/backwordbutton-loginpage.dart';
import '../../widgets/SocialLoginButton.dart';
import '/utils/colors.dart';
import '../Test/ATEC_screen.dart';
import '../../functionDatabase/auth_service.dart'; // ✅ เพิ่ม import

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive values
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.05;
    final double verticalPadding = size.height * 0.025;
    final double titleFontSize = size.width * 0.07;
    final double subtitleFontSize = size.width * 0.036;
    final double inputFontSize = size.width * 0.035;
    final double buttonFontSize = size.width * 0.045;
    final double buttonHeight = size.height * 0.08;
    final double cardTopRadius = size.width * 0.15;
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    final AuthService _authService = AuthService(); // ✅ สร้าง instance

    return Scaffold(
      backgroundColor: AppColors.yellowPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section with Back Button and Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtonWidget(top: 16, left: 10),
                  SizedBox(height: verticalPadding * 2),

                  // Title
                  Text(
                    'SIGN UP',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownPrimary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: verticalPadding),

                  // Subtitle
                  Text(
                    'สวัสดี\nเราคือแอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.5,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    'โปรดตั้งค่าชื่อผู้ใช้ และรหัสผ่าน',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: subtitleFontSize,
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cardTopRadius),
                    topRight: Radius.circular(cardTopRadius),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding * 1.6,
                    verticalPadding * 2.5,
                    horizontalPadding * 1.6,
                    verticalPadding * 1.3,
                  ),
                  child: Column(
                    children: [
                      // Username
                      TextField(
                        controller: _usernameController,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: inputFontSize,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'อีเมล',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: inputFontSize + 2,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 0.8,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding * 1.2),

                      // Password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: inputFontSize,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: inputFontSize + 2,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 0.8,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding * 1.8),

                      // Confirm Password
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: inputFontSize,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 138, 114, 109),
                        ),
                        decoration: InputDecoration(
                          hintText: 'ยืนยันรหัสผ่าน',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: inputFontSize - 2,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brownTertiary,
                          ),
                          filled: true,
                          fillColor: AppColors.cream,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding * 0.8,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding * 1.8),

                      // Register Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding * 0.8,
                          vertical: verticalPadding * 2.5,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: () async {
                              final email = _usernameController.text.trim();
                              final password = _passwordController.text.trim();
                              final confirmPassword = _confirmPasswordController.text.trim();

                              // Validation
                              if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                                );
                                return;
                              }
                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('รหัสผ่านไม่ตรงกัน')),
                                );
                                return;
                              }
                              if (password.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร')),
                                );
                                return;
                              }

                              // Register with Firebase Auth
                              final user = await _authService.register(email, password);
                              if (user != null) {
                                // สมัครสำเร็จ
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('สมัครสมาชิกสำเร็จ')),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ATECHomePage(),
                                  ),
                                );
                              } else {
                                // สมัครไม่สำเร็จ
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('สมัครสมาชิกไม่สำเร็จ')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brownPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'สมัครสมาชิก',
                              style: GoogleFonts.barlowSemiCondensed(
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding * 1.8),

                      // Divider
                      SizedBox(height: verticalPadding * 1.3),

                      // Social Login (add your widget here if needed)
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