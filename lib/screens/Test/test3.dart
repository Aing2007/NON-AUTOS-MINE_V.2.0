import 'package:flutter/material.dart';
import 'test2.dart';
import 'test4.dart';

class Test3Screen extends StatefulWidget {
  final int? score1;
  final int? score2;

  const Test3Screen({Key? key, this.score1, this.score2}) : super(key: key);

  @override
  State<Test3Screen> createState() => _Test3ScreenState();
}

class _Test3ScreenState extends State<Test3Screen> {
  final List<String> _questions = [
    'ตอบสนองต่อการเรียกชื่อ',
    'ตอบสนองต่อการชมเชย',
    'มองดูคนและสัตว์',
    'มองดูรูปภาพ (และโทรทัศน์)',
    'วาดรูป ระบายสี ทำงานศิลปะ',
    'เล่นของเล่นได้หมาะสม',
    'แสดงความรู้สึกออกทางสีหน้าได้เหมาะสม',
    'เข้าใจเรื่องราวในโทรทัศน์',
    'เข้าใจเวลาอธิบายให้ฟัง',
    'มีความตระหนักในสิ่งแวดล้อมรอบตัว',
    'มีความตระหนักระมัดระวังอันตราย',
    'แสดงให้เห็นว่ามีจินตนาการ (เช่น เล่นสมมุติเป็น)',
    'มีความคิดริเริ่มทำกิจกรรม',
    'ใส่เสื้อผ้าได้เอง',
    'แสดงความสนใจ อยากรู้อยากเห็น',
    'กล้าเสี่ยง ชอบสำรวจ',
    'จดจ่อในสิ่งที่สนใจอยู่อย่างมากไม่สนใจสิ่งรอบตัว',
    'มองตามสิ่งที่คนอื่นกำลังมองอยู่',
  ];

  List<int?> _answers = List.filled(18, null);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(254, 211, 113, 1),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: height * 0.2,
              child: Container(
                width: width,
                height: height * 0.80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),

            const Positioned(
              left: 30,
              top: 45,
              child: Text(
                '3.ด้านประสาทรับ\nความรู้สึกและการรับรู้',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Barlow Semi Condensed',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const Positioned(
              left: 30,
              top: 170,
              child: SizedBox(
                width: 250,
                child: Text(
                  'จำนวน 18 ข้อ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Barlow Semi Condensed',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            Positioned(
              right: 25,
              top: 51,
              child: Container(
                width: 130,
                height: 130,
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
                    'assets/images/ICON.png', // ✅ เปลี่ยน path เป็นของคุณ
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: height * 0.25,
              left: 0,
              right: 0,
              bottom: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${_questions[index]}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 58, 58, 58),
                              fontSize: 16,
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
                                      254,
                                      211,
                                      113,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("ไม่มี"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(
                                      254,
                                      211,
                                      113,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("บางครั้ง"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: _answers[index],
                                    activeColor: const Color.fromRGBO(
                                      254,
                                      211,
                                      113,
                                      1,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("มาก"),
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

            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: width,
                height: 100,
                color: const Color.fromRGBO(254, 211, 113, 1),
              ),
            ),

            Positioned(
              left: 22,
              bottom: 45,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test2Screen(score1: widget.score1),
                    ),
                  );
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: const Color.fromRGBO(254, 211, 113, 1),
                    size: 30,
                  ),
                ),
              ),
            ),

            Positioned(
              right: 22,
              bottom: 45,
              child: GestureDetector(
                onTap: () {
                  // ป้องกันการส่งคำตอบว่าง

                  // คำนวณคะแนนตามเงื่อนไข
                  int test3_score = 0;
                  for (var answer in _answers) {
                    if (answer == 0) {
                      test3_score += 2; // ไม่มี
                    } else if (answer == 1) {
                      test3_score += 1; // บางครั้ง
                    } else if (answer == 2) {
                      test3_score += 0; // มาก
                    }
                  }

                  // ตัวอย่าง: ไปหน้า ProfileScreen พร้อมส่งคะแนน
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test4Screen(
                        score1: widget.score1,
                        score2: widget.score2,
                        score3: test3_score,
                      ),
                      settings: const RouteSettings(arguments: {}),
                    ),
                  );
                },

                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color.fromRGBO(254, 211, 113, 1),
                    size: 30,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 80,
              right: 80,
              bottom: 45,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            Positioned(
              left:
                  75 +
                  (width - 130) * 0.51, // เริ่มจากซ้าย + 15% ของความกว้างแถบขาว

              bottom: 48,
              child: Container(
                width: (width - 130) * 0.25, // 70% ของความกว้างแถบขาว
                height: 34,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(254, 211, 113, 1),
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
