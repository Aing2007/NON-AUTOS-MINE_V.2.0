import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/backwordbutton-loginpage.dart';
import '/utils/colors.dart';
import '../start_screen.dart';
import '../../functionDatabase/auth_service.dart'; // ✅ เพิ่ม import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final User? user = await _authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        // ✅ Login สำเร็จ → ไปหน้า StartScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
        );
      } else {
        setState(() {
          _errorMessage = "อีเมลหรือรหัสผ่านไม่ถูกต้อง";
        });
      }
    } on FirebaseAuthException catch (e) {
      // ✅ Error จาก Firebase (กรณีไม่พบผู้ใช้ / รหัสผ่านผิด)
      setState(() {
        _errorMessage = e.message ?? "เกิดข้อผิดพลาดในการเข้าสู่ระบบ";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "เกิดข้อผิดพลาด: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.06;
    final double verticalPadding = size.height * 0.025;
    final double titleFontSize = size.width * 0.09;
    final double subtitleFontSize = size.width * 0.045;
    final double inputFontSize = size.width * 0.035;
    final double buttonFontSize = size.width * 0.055;
    final double buttonHeight = size.height * 0.08;
    final double cardTopRadius = size.width * 0.15;

    return Scaffold(
      backgroundColor: AppColors.yellowPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtonWidget(top: 16, left: 16),
                  SizedBox(height: verticalPadding * 2),
                  Text(
                    'LOG IN',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownPrimary,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: verticalPadding),
                  Text(
                    'ยินดีต้อนรับกลับ เราคือแอปพลิเคชันเพื่อส่งเสริมพัฒนาการของเด็กออทิสติก\n',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brownSecondary,
                      letterSpacing: 0.8,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    'โปรดกรอกข้อมูลเพื่อเข้าสู่ระบบ',
                    style: GoogleFonts.barlowSemiCondensed(
                      fontSize: subtitleFontSize,
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
                    horizontalPadding * 1.5,
                    verticalPadding * 2.5,
                    horizontalPadding * 1.5,
                    verticalPadding * 1.5,
                  ),
                  child: Column(
                    children: [
                      // Email
                      TextField(
                        controller: _emailController,
                        style: GoogleFonts.barlowSemiCondensed(
                          fontSize: inputFontSize,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownTertiary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'อีเมล',
                          hintStyle: GoogleFonts.barlowSemiCondensed(
                            fontSize: inputFontSize,
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
                            horizontal: horizontalPadding * 1.4,
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
                            fontSize: inputFontSize,
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
                            horizontal: horizontalPadding * 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding * 2),

                      // Error message
                      if (_errorMessage != null) ...[
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        SizedBox(height: verticalPadding),
                      ],

                      // Login Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding * 0.8,
                          vertical: verticalPadding * 2.5,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brownPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'เข้าสู่ระบบ',
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
