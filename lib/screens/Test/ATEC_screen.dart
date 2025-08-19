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
    // Responsive values
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.06;
    final double verticalPadding = size.height * 0.02;
    final double headerFontSize = size.width * 0.10;
    final double subHeaderFontSize = size.width * 0.030;
    final double formLabelFontSize = size.width * 0.06;
    final double formHintFontSize = size.width * 0.030;
    final double radioFontSize = size.width * 0.04;
    final double cardTopRadius = size.width * 0.15;
    final double avatarRadius = size.width * 0.10;
    final double formFieldHeight = size.height * 0.08;
    final double navButtonSize = size.width * 0.13;
    final double navBarHeight = size.height * 0.08;

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
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      verticalPadding,
                      horizontalPadding * 4,
                      verticalPadding * 1.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ATEC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: headerFontSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.4,
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.3),
                        Text(
                          'แบบประเมินนี้ได้ถูกจัดทำขึ้นตามแนวคิดของ Rimland Rimland, Ph.D. & Stephen M. Edelson, Ph.D. \nและได้รับการแปลโดย วนาลักษณ์ เมืองมลมณีรัตน์ และ ภัทราภรณ์ ทุ่งปันคา',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: formHintFontSize,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.8),
                        Text(
                          'คำชี้แจง: ข้อคำถามในแบบประเมินนี้สำหรับผู้ปกครอง หรือผู้ดูแลเด็ก กรุณาอ่านคำถามต่อไปนี้โดยละเอียดและ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: subHeaderFontSize,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.6),
                        Text(
                          'เลือกคำตอบที่ท่านสังเกตเห็นใกล้เคียงกับพฤติกรรมเด็กมากที่สุดภายใน 1 เดือนที่ผ่านมา',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: subHeaderFontSize,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: verticalPadding * 2,
                    right: horizontalPadding,
                    child: CircleAvatar(
                      radius: avatarRadius,
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
                        child: Center(
                          child: CircleAvatar(
                            radius: avatarRadius,
                            backgroundImage: const AssetImage(
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
                constraints: BoxConstraints(
                  minHeight: size.height * 0.75,
                  maxHeight: size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(cardTopRadius)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  verticalPadding * 2,
                  horizontalPadding,
                  verticalPadding * 2.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(
                      'Name of Child',
                      _childNameController,
                      'Enter child\'s name',
                      formLabelFontSize,
                      formFieldHeight,
                      formHintFontSize,
                    ),
                    SizedBox(height: verticalPadding * 1.5),
                    Text(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: formLabelFontSize,
                        fontWeight: FontWeight.w700,
                        color: atecBrown,
                      ),
                    ),
                    SizedBox(height: verticalPadding * 0.5),
                    Text(
                      '(format: MM/DD/YYYY, Example: 09/25/1998)',
                      style: TextStyle(
                        fontSize: formHintFontSize,
                        fontWeight: FontWeight.w700,
                        color: atecMuted,
                      ),
                    ),
                    SizedBox(height: verticalPadding),
                    _buildTextField(_dateOfBirthController, 'MM/DD/YYYY', formFieldHeight, formHintFontSize),
                    SizedBox(height: verticalPadding * 1.5),
                    Text(
                      'Sex',
                      style: TextStyle(
                        fontSize: formLabelFontSize,
                        fontWeight: FontWeight.w700,
                        color: atecBrown,
                      ),
                    ),
                    SizedBox(height: verticalPadding * 1.2),
                    Row(
                      children: [
                        _buildRadioOption('female', 'Female', radioFontSize),
                        SizedBox(width: horizontalPadding * 2),
                        _buildRadioOption('male', 'Male', radioFontSize),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Navigation
              Container(
                height: navBarHeight,
                width: double.infinity,
                color: atecBrown,
                padding: EdgeInsets.only(top: verticalPadding * 1.2),
                child: Row(
                  children: [
                    buildNavButton(Icons.chevron_left, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }, navButtonSize),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.7),
                        height: navBarHeight * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: horizontalPadding * 0.3),
                            width: navBarHeight,
                            height: navBarHeight * 0.45,
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
                    }, navButtonSize),
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
    double labelFontSize,
    double fieldHeight,
    double hintFontSize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w700,
            color: atecBrown,
          ),
        ),
        SizedBox(height: 16),
        _buildTextField(controller, placeholder, fieldHeight, hintFontSize),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String placeholder, double fieldHeight, double hintFontSize) {
    return Container(
      height: fieldHeight,
      decoration: BoxDecoration(
        color: atecLightBg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: fieldHeight * 0.28,
          ),
          hintStyle: TextStyle(fontSize: hintFontSize),
        ),
        style: TextStyle(fontSize: hintFontSize + 5),
      ),
    );
  }

  Widget _buildRadioOption(String value, String label, double radioFontSize) {
    final isSelected = selectedSex == value;
    return GestureDetector(
      onTap: () => setState(() => selectedSex = value),
      child: Row(
        children: [
          Container(
            width: radioFontSize * 1.4,
            height: radioFontSize * 1.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? atecBrown : atecMuted,
            ),
            child: isSelected
                ? Center(
                    child: CircleAvatar(
                      radius: radioFontSize * 0.35,
                      backgroundColor: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(width: radioFontSize * 0.8),
          Text(
            label,
            style: TextStyle(
              fontSize: radioFontSize,
              fontWeight: FontWeight.w700,
              color: isSelected ? atecBrown : atecMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavButton(IconData icon, VoidCallback onPressed, double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: atecBrown, size: size * 0.5),
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