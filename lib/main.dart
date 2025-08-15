import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const ChildrenApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'BarlowSemiCondensed', // เปลี่ยนหรือเอาออกถ้าไม่มีฟอนต์นี้
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false, // ปิดแถบ debug
    );
  }
}

class ChildrenApp extends StatelessWidget {
  const ChildrenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NON-Autos mine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.barlowSemiCondensedTextTheme(),
        fontFamily: GoogleFonts.barlowSemiCondensed().fontFamily,
      ),
      home: WelcomeScreen(),
    );
  }
}
