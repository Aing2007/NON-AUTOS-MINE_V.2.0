import 'package:flutter/material.dart';
import 'test2.dart';
import 'ATEC_screen.dart';

class Test1Screen extends StatefulWidget {
  const Test1Screen({Key? key}) : super(key: key);

  @override
  State<Test1Screen> createState() => _Test1ScreenState();
}

class _Test1ScreenState extends State<Test1Screen> {
  final List<String> _questions = [
    'รู้จักชื่อตนเอง',
    'ตอบสนองต่อคำสั่งว่า “ไม่” หรือ “หยุด”',
    'ทำตามคำสั่งบางอย่างได้',
    'พูดเป็นคำๆได้เช่น ไม่ กิน น้ำ เป็นต้น',
    'พูด 2 คำติดกัน เช่น ไม่เอา กลับบ้าน เป็นต้น',
    'พูด 3 คำติดกัน เช่น ขอนมอีก เป็นต้น',
    'รู้จักคำ 10 คำ หรือ มากกว่า',
    'พูดประโยคที่มี 4 คำ ขึ้นไป',
    'พูดอธิบายความต้องการของตัวเองได้',
    'ถามคำถามที่มีความหมาย',
    'คำพูดมีความหมาย/มีความเชื่อมโยง',
    'มักใช้ประโยคที่พูดได้ค่อนข้างบ่อย',
    'พูดคุยโต้ตอบได้ต่อเนื่องค่อนข้างดี',
    'สามารถสื่อสารได้สมวัย',
  ];

  List<int?> _answers = List.filled(14, null);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double horizontalPadding = width * 0.05;
    final double verticalPadding = height * 0.02;
    final double titleFontSize = width * 0.053;
    final double subtitleFontSize = width * 0.039;
    final double questionFontSize = width * 0.042;
    final double radioFontSize = width * 0.038;
    final double avatarSize = width * 0.28;
    final double navButtonSize = width * 0.11;
    final double navBarHeight = height * 0.10;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(color: Color(0xFF7F95E4)),
        child: Stack(
          children: [
            // White container background
            Positioned(
              left: 0,
              top: height * 0.19,
              child: Container(
                width: width,
                height: height * 0.81,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.15),
                    topRight: Radius.circular(width * 0.15),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),

            // Title
            Positioned(
              left: horizontalPadding,
              top: verticalPadding * 2.2,
              child: Text(
                '1.ด้านการพูดและการใช้\nภาษาติดต่อสื่อสาร',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Barlow Semi Condensed',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // จำนวนข้อ
            Positioned(
              left: horizontalPadding,
              top: verticalPadding * 6.5,
              child: SizedBox(
                width: width * 0.5,
                child: Text(
                  'จำนวน 14 ข้อ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Barlow Semi Condensed',
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            // Avatar
            Positioned(
              right: horizontalPadding,
              top: verticalPadding * 2.5,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8BC7AD),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/ICON.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // คำถามแบบสอบถาม
            Positioned(
              top: height * 0.25,
              left: 0,
              right: 0,
              bottom: navBarHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalPadding * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${_questions[index]}',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 58, 58, 58),
                              fontSize: questionFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 0,
                                    groupValue: _answers[index],
                                    activeColor: const Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("ไม่จริง", style: TextStyle(fontSize: radioFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _answers[index],
                                    activeColor: const Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("บางครั้งจริง", style: TextStyle(fontSize: radioFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: _answers[index],
                                    activeColor: const Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("จริงมาก", style: TextStyle(fontSize: radioFontSize)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Navbar พื้นหลังล่างสุด
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: width,
                height: navBarHeight,
                color: const Color(0xFF7F95E4),
              ),
            ),

            // ปุ่มย้อนกลับ (ซ้าย)
            Positioned(
              left: horizontalPadding,
              bottom: navBarHeight * 0.38,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ATECHomePage(),
                    ),
                  );
                },
                child: Container(
                  width: navButtonSize,
                  height: navButtonSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color(0xFF7F95E4),
                    size: navButtonSize * 0.7,
                  ),
                ),
              ),
            ),

            // ปุ่มถัดไป (ขวา)
            Positioned(
              right: horizontalPadding,
              bottom: navBarHeight * 0.38,
              child: GestureDetector(
                onTap: () {
                  int test1_score = 0;
                  for (var answer in _answers) {
                    if (answer == 0) {
                      test1_score += 2;
                    } else if (answer == 1) {
                      test1_score += 1;
                    } else if (answer == 2) {
                      test1_score += 0;
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test2Screen(score1: test1_score),
                    ),
                  );
                },
                child: Container(
                  width: navButtonSize,
                  height: navButtonSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFF7F95E4),
                    size: navButtonSize * 0.7,
                  ),
                ),
              ),
            ),

            // แถบขาว (ยืดตามความกว้างของหน้าจอ เว้นซ้าย-ขวา)
            Positioned(
              left: width * 0.18,
              right: width * 0.18,
              bottom: navBarHeight * 0.43,
              child: Container(
                height: navBarHeight * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            // Progress bar (สีหลัก)
            Positioned(
              left: width * 0.19,
              bottom: navBarHeight * 0.46,
              child: Container(
                width: width * 0.2,
                height: navBarHeight * 0.34,
                decoration: BoxDecoration(
                  color: const Color(0xFF7F95E4),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}