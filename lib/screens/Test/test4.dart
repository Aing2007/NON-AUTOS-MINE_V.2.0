import 'package:flutter/material.dart';
import 'test3.dart';
import '../start_screen.dart';
import '../profile_screen.dart';
import '/screens/Loading_screen.dart';

class Test4Screen extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  const Test4Screen({Key? key, this.score1, this.score2, this.score3})
    : super(key: key);

  @override
  State<Test4Screen> createState() => _Test1ScreenState();
}

class _Test1ScreenState extends State<Test4Screen> {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                '4.ด้านสุขภาพร่างกาย\nและพฤติกรรม',
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
                  'จำนวน 25 ข้อ',
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
              bottom: 100, // เผื่อ space สำหรับ Navbar
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
                                  const Text("ไม่มี"),
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
                                  const Text("เล็กน้อย"),
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
                                  const Text("ปานกลาง"),
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
                color: const Color.fromRGBO(139, 199, 173, 1),
              ),
            ),

            // ปุ่มย้อนกลับ (ซ้าย)
            Positioned(
              left: 22,
              bottom: 45,
              child: GestureDetector(
                onTap: () {
                  // คำนวณคะแนนตามเงื่อนไข

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
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(139, 199, 173, 1),
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
                  int test4_score = 0;
                  for (var answer in _answers) {
                    if (answer == 0) {
                      test4_score += 0; // ไม่มี
                    } else if (answer == 1) {
                      test4_score += 1; // เล็กน้อย
                    } else if (answer == 2) {
                      test4_score += 2; // ปานกลาง
                    } else if (answer == 3) {
                      test4_score += 3; // มาก
                    }
                  }

                  // ส่งไปหน้า StartScreen หรือหน้าอื่น พร้อมส่ง test4_score ถ้าต้องการ
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingAnalysisPage(
                        score1: widget.score1,
                        score2: widget.score2,
                        score3: widget.score3,
                        score4: test4_score,
                      ), // หรือหน้าอื่นที่ต้องการ
                    ),
                  );

                  // หากต้องการใช้ test4_score ที่หน้าอื่น อย่าลืมส่งผ่าน constructor ด้วย
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
                    color: Color.fromRGBO(139, 199, 173, 1),
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

            // แถบสีด้านใน
            Positioned(
              left:
                  36 +
                  (width - 130) * 0.76, // เริ่มจากซ้าย + 15% ของความกว้างแถบขาว

              bottom: 48,
              child: Container(
                width: (width - 130) * 0.25, // 70% ของความกว้างแถบขาว
                height: 34,
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
