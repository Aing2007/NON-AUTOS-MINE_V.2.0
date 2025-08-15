import 'package:flutter/material.dart';
import 'test1.dart';
import '../Login+signup/signin_screen.dart';

void main() {
  runApp(const ATECApp());
}

class ATECApp extends StatelessWidget {
  const ATECApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATEC - Child Development',
      theme: ThemeData(
        fontFamily: 'BarlowSemiCondensed',
        primarySwatch: Colors.brown,
      ),
      home: const ATECHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ATECHomePage extends StatefulWidget {
  const ATECHomePage({super.key});

  @override
  State<ATECHomePage> createState() => _ATECHomePageState();
}

class _ATECHomePageState extends State<ATECHomePage> {
  String? selectedSex;
  final TextEditingController _childNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  static const Color atecBrown = Color(0xFF5F4A46);
  static const Color atecLightBg = Color(0xFFF5F3F0);
  static const Color atecGreen = Color(0xFF8ACCAF);
  static const Color atecMuted = Color(0xFFC3B8B1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: atecBrown,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 96, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'ATEC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 58,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.4,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'แบบประเมินนี้ได้ถูกจัดทำขึ้นตามแนวคิดของ Rimland Rimland, Ph.D. & Stephen M. Edelson, Ph.D. \nและได้รับการแปลโดย วนาลักษณ์ เมืองมลมณีรัตน์ และ ภัทราภรณ์ ทุ่งปันคา',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 17),
                        Text(
                          'คำชี้แจง: ข้อคำถามในแบบประเมินนี้สำหรับผู้ปกครอง หรือผู้ดูแลเด็ก กรุณาอ่านคำถามต่อไปนี้โดยละเอียดและ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'เลือกคำตอบที่ท่านสังเกตเห็นใกล้เคียงกับพฤติกรรมเด็กมากที่สุดภายใน 1 เดือนที่ผ่านมา',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 20,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: atecGreen,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 255, 255, 255),
                              const Color.fromARGB(255, 188, 194, 192),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/ICON.png',
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Form Section
              Container(
                width: double.infinity,
                height: 730,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(
                      'Name of Child',
                      _childNameController,
                      'Enter child\'s name',
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: atecBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '(format: MM/DD/YYYY, Example: 09/25/1998)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: atecMuted,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(_dateOfBirthController, 'MM/DD/YYYY'),
                    const SizedBox(height: 32),
                    const Text(
                      'Sex',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: atecBrown,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildRadioOption('female', 'Female'),
                        const SizedBox(width: 48),
                        _buildRadioOption('male', 'Male'),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Navigation
              Container(
                height: 60,

                width: double.infinity,
                color: atecBrown,
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    buildNavButton(Icons.chevron_left, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 18),
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 56,
                            height: 28,
                            decoration: BoxDecoration(
                              color: atecBrown,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildNavButton(Icons.chevron_right, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Test1Screen(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller,
    String placeholder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: atecBrown,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(controller, placeholder),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: atecLightBg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
        ),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildRadioOption(String value, String label) {
    final isSelected = selectedSex == value;
    return GestureDetector(
      onTap: () => setState(() => selectedSex = value),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? atecBrown : atecMuted,
            ),
            child: isSelected
                ? const Center(
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isSelected ? atecBrown : atecMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: atecBrown, size: 24),
        onPressed: onPressed,
      ),
    );
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }
}
