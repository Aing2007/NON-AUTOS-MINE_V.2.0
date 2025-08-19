import 'package:flutter/material.dart';
import 'test1.dart';
import 'test3.dart';

class Test2Screen extends StatefulWidget {
  final int? score1;

  const Test2Screen({Key? key, this.score1}) : super(key: key);

  @override
  State<Test2Screen> createState() => _Test2ScreenState();
}

class _Test2ScreenState extends State<Test2Screen> {
  final List<String> _questions = [
    'ดูเหมือนอยู่ในโลกส่วนตัวที่คุณไม่สามารถเข้าถึงได้',
    'ไม่สนใจบุคคลอื่น',
    'ให้ความสนใจน้อย หรือไม่สนใจเลย เมื่อถูกเรียกหา',
    'ไม่ร่วมมือและต่อต้าน',
    'ไม่สบตา',
    'รู้สึกชอบมากกว่าเมื่อปล่อยให้อยู่คนเดียว',
    'ไม่แสดงความรู้สึก (หน้าแสดงออกเฉยเมย)',
    'ไม่ทักทายพ่อแม่',
    'หลีกเลี่ยงการติดต่อผู้อื่น',
    'ไม่ทำเลียนแบบ',
    'ไม่ชอบใหอุ้ม หรือกอดซุกไซ้',
    'ไม่แบ่งปัน หรือไม่อวดของ',
    'ไม่โบกมือลา (บ๊าย บาย)',
    'ไม่เห็นด้วย/ไม่ยินยอม',
    'ร้องอาละวาด/ลงนอนดิ้น/ลงมือลงเท้า',
    'ไม่มีเพื่อนฝูง',
    'ยิ้มยาก',
    'ไม่รู้สึกอะไร(เฉยเมย) ต่อความรู้สึกของผู้อื่น',
    'ไม่สนใจ(เฉยเมย) เมื่อมีคนอื่นแสดงความชื่นชอบตนเอง',
    'ไม่สนใจ(เฉยเมย) เมื่อพ่อแม่เดินจากไป',
  ];

  List<int?> _answers = List.filled(20, null);

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
        decoration: const BoxDecoration(color: Color.fromRGBO(246, 90, 59, 1)),
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
                '2.ด้านความสามารถ\nทางสังคม',
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
                  'จำนวน 20 ข้อ',
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
                                    activeColor: const Color.fromRGBO(246, 90, 59, 1),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("ไม่มี", style: TextStyle(fontSize: radioFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(246, 90, 59, 1),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("บางครั้ง", style: TextStyle(fontSize: radioFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(246, 90, 59, 1),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text("มาก", style: TextStyle(fontSize: radioFontSize)),
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
                color: const Color.fromRGBO(246, 90, 59, 1),
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
                      builder: (context) => const Test1Screen(),
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
                    color: const Color.fromRGBO(246, 90, 59, 1),
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
                  int test2_score = 0;
                  for (var answer in _answers) {
                    if (answer != null) {
                      test2_score += answer;
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test3Screen(
                        score1: widget.score1,
                        score2: test2_score,
                      ),
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
                    color: const Color.fromRGBO(246, 90, 59, 1),
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
                  color: const Color.fromRGBO(246, 90, 59, 1),
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