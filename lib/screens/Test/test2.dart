import 'package:flutter/material.dart';
import 'test1.dart';
import 'test3.dart';

class Test2Screen extends StatefulWidget {
  final int? score1;

  const Test2Screen({Key? key, this.score1}) : super(key: key);

  @override
  State<Test2Screen> createState() => _Test3ScreenState();
}

class _Test3ScreenState extends State<Test2Screen> {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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

            // Title
            const Positioned(
              left: 30,
              top: 45,
              child: Text(
                '2.ด้านความสามารถ\nทางสังคม',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Barlow Semi Condensed',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // จำนวนข้อ
            const Positioned(
              left: 30,
              top: 175,
              child: SizedBox(
                width: 250,
                child: Text(
                  'จำนวน 20 ข้อ',
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

            // Avatar
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

            // คำถามแบบสอบถาม
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
                                      246,
                                      90,
                                      59,
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
                                      246,
                                      90,
                                      59,
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
                                      246,
                                      90,
                                      59,
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

            // Navbar พื้นหลังล่างสุด
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: width,
                height: 100,
                color: const Color.fromRGBO(246, 90, 59, 1),
              ),
            ),

            // ปุ่มย้อนกลับ (ซ้าย)
            Positioned(
              left: 22,
              bottom: 45,
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
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(246, 90, 59, 1),
                    size: 30,
                  ),
                ),
              ),
            ),

            // ปุ่มถัดไป (ขวา)
            Positioned(
              right: 22,
              bottom: 45,
              child: GestureDetector(
                onTap: () {
                  // ตรวจสอบว่าทุกข้อมีคำตอบ

                  // คำนวณคะแนนรวมจากแบบสอบถาม
                  int test2_score = 0;
                  for (var answer in _answers) {
                    if (answer != null) {
                      test2_score += answer; // 0 = ไม่มี, 1 = บางครั้ง, 2 = มาก
                    }
                  }

                  // ไปยังหน้าถัดไป (คุณสามารถส่ง test2_score ไปด้วยได้)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test3Screen(
                        score1: widget.score1,
                        score2: test2_score,
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
                    color: Color.fromRGBO(246, 90, 59, 1),
                    size: 30,
                  ),
                ),
              ),
            ),

            // แถบขาว
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

            // แถบสีด้านใน
            Positioned(
              left:
                  75 +
                  (width - 130) * 0.26, // เริ่มจากซ้าย + 15% ของความกว้างแถบขาว

              bottom: 48,
              child: Container(
                width: (width - 130) * 0.25, // 70% ของความกว้างแถบขาว
                height: 34,
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
