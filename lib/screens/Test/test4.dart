import 'package:flutter/material.dart';
import 'test3.dart';
import '../start_screen.dart';
import '../profile_screen.dart';
import '/screens/Loading_screen.dart';
import 'package:non_autos_mine/screens/Loding_man.dart';

class Test4Screen extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  const Test4Screen({Key? key, this.score1, this.score2, this.score3})
    : super(key: key);

  @override
  State<Test4Screen> createState() => _Test4ScreenState();
}

class _Test4ScreenState extends State<Test4Screen> {
  final List<String> _questions = [
    'ปัสสาวะรดที่นอน',
    'ปัสสาวะรดกางเกง/ ผ้าอ้อม',
    'อุจจาระรดกางเกง/ ผ้าอ้อม',
    'ท้องเสีย',
    'ท้องผูก',
    'มีปัญหาการนอน',
    'รับประทานอาหารมากเกินไป/ น้อยเกินไป',
    'มีข้อจำกัดเรื่องการรับประทานอย่างมาก (เช่น รับประทานอาหารได้น้อยอย่าง)',
    'ไม่อยู่นิ่ง',
    'เซื่องซึม',
    'ทุบตี หรือ ทำร้ายตัวเอง',
    'ทุบตี หรือ ทำร้ายผู้อื่น',
    'ทำลายของ',
    'รู้สึกไวต่อเสียง',
    'วิตกกังวล/หวาดกลัว',
    'ไม่มีความสุข/ร้องไห้',
    'มีอาการชัก',
    'พูดซ้ำ ๆ',
    'ติดกับกิจวตัรซ้ำ ๆ ย้ำทำไม่ยอมรับการเปลี่ยนแปลงหรือไม่ยืดหยุ่น \n(เช่น กลับบ้านทางเดิมๆ, เปิด-ปิดไฟเวลาเดิมๆ,แปรงฟันเวลาเดิมๆ)',
    'ตะโกน หรือ ร้องกรี๊ด',
    'ต้องการสิ่งเดิมๆ',
    'กระวนกระวายใจบ่อยๆ',
    'ไม่รู้สึกเจ็บปวด',
    'ยึดติดอยู่กับสิ่งของหรือเรื่องบางเรื่อง',
    'มีการเคลื่อนไหวร่างกายซ้ำ ๆ(เช่น กระตุ้นตัวเอง โยกตัว)',
  ];

  List<int?> _answers = List.filled(25, null);

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
        decoration: const BoxDecoration(
          color: Color.fromRGBO(139, 199, 173, 1),
        ),
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
                '4.ด้านสุขภาพร่างกาย\nและพฤติกรรม',
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
                  'จำนวน 25 ข้อ',
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
                                    activeColor: const Color.fromRGBO(
                                      139,
                                      199,
                                      173,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "ไม่มี",
                                    style: TextStyle(fontSize: radioFontSize),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(
                                      139,
                                      199,
                                      173,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "เล็กน้อย",
                                    style: TextStyle(fontSize: radioFontSize),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(
                                      139,
                                      199,
                                      173,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "ปานกลาง",
                                    style: TextStyle(fontSize: radioFontSize),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 3,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(
                                      139,
                                      199,
                                      173,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "มาก",
                                    style: TextStyle(fontSize: radioFontSize),
                                  ),
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
                color: const Color.fromRGBO(139, 199, 173, 1),
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
                      builder: (context) => Test3Screen(
                        score1: widget.score1,
                        score2: widget.score2,
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
                    Icons.arrow_back,
                    color: const Color.fromRGBO(139, 199, 173, 1),
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
                  int test4_score = 0;
                  for (var answer in _answers) {
                    if (answer == 0) {
                      test4_score += 0;
                    } else if (answer == 1) {
                      test4_score += 1;
                    } else if (answer == 2) {
                      test4_score += 2;
                    } else if (answer == 3) {
                      test4_score += 3;
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingManPage(
                        score1: widget.score1,
                        score2: widget.score2,
                        score3: widget.score3,
                        score4: test4_score,
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
                    color: const Color.fromRGBO(139, 199, 173, 1),
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
                width: width * 0.61,
                height: navBarHeight * 0.34,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(139, 199, 173, 1),
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
