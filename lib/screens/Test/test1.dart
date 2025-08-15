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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                '1.ด้านการพูดและการใช้\nภาษาติดต่อสื่อสาร',
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
                  'จำนวน 14 ข้อ',
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
              bottom: 80, // เผื่อ space สำหรับ Navbar
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ), //ระยะห่างระหว่างคำถาม
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
                                    activeColor: Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("ไม่จริง"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: _answers[index],
                                    activeColor: Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("บางครั้งจริง"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue: _answers[index],
                                    activeColor: Color(0xFF7F95E4),
                                    onChanged: (value) {
                                      setState(() {
                                        _answers[index] = value;
                                      });
                                    },
                                  ),
                                  const Text("จริงมาก"),
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
                color: const Color(0xFF7F95E4),
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
                      builder: (context) => const ATECHomePage(),
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
                    color: Color(0xFF7F95E4),
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
                  // ตรวจสอบว่ามีคำตอบว่างหรือไม่

                  // คำนวณคะแนนตามเกณฑ์
                  int test1_score = 0;
                  for (var answer in _answers) {
                    if (answer == 0) {
                      test1_score += 2; // ไม่จริง
                    } else if (answer == 1) {
                      test1_score += 1; // บางครั้งจริง
                    } else if (answer == 2) {
                      test1_score += 0; // จริงมาก
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
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF7F95E4),
                    size: 30,
                  ),
                ),
              ),
            ),

            // แถบขาว (ยืดตามความกว้างของหน้าจอ เว้นซ้าย-ขวา 65)
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
                  (width - 130) * 0.01, // เริ่มจากซ้าย + 15% ของความกว้างแถบขาว

              bottom: 48,
              child: Container(
                width: (width - 130) * 0.25, // 70% ของความกว้างแถบขาว
                height: 34,
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
