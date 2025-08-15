import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/SUM_screen.dart';

class LoadingAnalysisPage extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;

  const LoadingAnalysisPage({
    Key? key,
    required this.score1,
    required this.score2,
    required this.score3,
    required this.score4,
  }) : super(key: key);

  @override
  _LoadingAnalysisPageState createState() => _LoadingAnalysisPageState();
}

class _LoadingAnalysisPageState extends State<LoadingAnalysisPage> {
  double progress = 0;
  late Timer _timer;

  late String summaryCode;
  late String explanation;
  late String levelCommunication;
  late String levelSocial;
  late String levelSense;
  late String levelHealth;
  late String overallLevel;

  @override
  void initState() {
    super.initState();
    startProcess();
  }

  Future<void> startProcess() async {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (progress < 95) {
          progress += 1;
        }
      });
    });

    try {
      final result = await sendToOpenRouter();
      extractResults(result);

      setState(() {
        progress = 100;
      });

      await Future.delayed(const Duration(milliseconds: 800));
      _timer.cancel();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SummaryPage(
            summaryCode: summaryCode,
            explanation: explanation,
            levelCommunication: levelCommunication,
            levelSocial: levelSocial,
            levelSense: levelSense,
            levelHealth: levelHealth,
            overallLevel: overallLevel,
            score1: widget.score1,
            score2: widget.score2,
            score3: widget.score3,
            score4: widget.score4,
          ),
        ),
      );
    } catch (e) {
      _timer.cancel();
      print("❌ ERROR: $e");
      // แสดงข้อความ error บนหน้าจอ
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("เกิดข้อผิดพลาด"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text("ตกลง"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<String> sendToOpenRouter() async {
    final int? score1 = widget.score1;
    final int? score2 = widget.score2;
    final int? score3 = widget.score3;
    final int? score4 = widget.score4;
    final prompt =
        '''
คุณคือผู้เชี่ยวชาญด้านพัฒนาการเด็กออทิสติก และมีความเชี่ยวชาญเฉพาะทางในการวิเคราะห์ผลการประเมิน ATEC (Autism Treatment Evaluation Checklist) สำหรับเด็กอายุ 5-12 ปี โดยจะมีคะแนนการประเมิน 4 ด้าน ได้แก่:

- score1 = คะแนนด้านการสื่อสาร (Communication)
- score2 = คะแนนด้านความสามารถในการเข้าสังคม (Socialization)
- score3 = คะแนนด้านการรับรู้ประสาทสัมผัส (Sensory / Cognitive awareness)
- score4 = คะแนนด้านสุขภาพร่างกายและพฤติกรรม (Health / Physical behavior)

คะแนนที่ได้รับคือ:
- score1: $score1
- score2: $score2
- score3: $score3
- score4: $score4

**คำชี้แจงสำหรับการตอบกลับ:**
1. วิเคราะห์ระดับความรุนแรงของแต่ละด้านแยกกัน (ทั้ง 4 ด้าน)
2. วิเคราะห์และสรุประดับอาการโดยรวม (overallLevel) โดยใช้คะแนนรวมของทั้ง 4 ด้าน
3. จัดลำดับตัวอักษรย่อของอาการทั้ง 4 ด้านจากรุนแรงมากที่สุดไปน้อยที่สุด โดยประเมินจากลำดับจากความรุนแรงของอาการแต่ละด้าน(อาการมาก->อาการน้อย)
และจากคะแนนที่ได้ในแต่ละด้าน(คะแนนมาก->คะแนนน้อย)และห้ามใช้ตัวอักษรซ้ำกันและ**ต้องใช้ครบทุกตัวอักษร**:
   - L = การสื่อสาร (Listening / Communication)
   - S = การเข้าสังคม (Social)
   - C = การรับรู้ประสาทสัมผัส (Sense)
   - H = สุขภาพและพฤติกรรม (Health)
   ตัวอย่าง: "LSCH"

4. สร้างคำอธิบาย (explanation) ที่สรุปปัญหาตามลำดับตัวอักษรใน summaryCode รวมไปถึงให้คำแนะนำกับผู้ปกครองเกี่ยวกับการดูแล
5. **ตอบกลับเฉพาะ JSON object ดิบเท่านั้น** โดยไม่ใส่ข้อความประกอบ
6. ห้ามมีคำอธิบายอื่น ห้ามใส่ Markdown หรือโค้ดบล็อก

**เกณฑ์การวิเคราะห์:**
- ด้าน L
  - 1–5 = น้อย
  - 6–14 = ปานกลาง
  - 15-28 = รุนแรง

- ด้าน S
  - 1–11 = น้อย
  - 12–16 = ปานกลาง
  - 17-40 = รุนแรง

- ด้าน C
  - 1–8 = น้อย
  - 9–15 = ปานกลาง
  - 16-36 = รุนแรง

- ด้าน H
  - 1–16 = น้อย
  - 17–29 = ปานกลาง
  - 30-75 = รุนแรง
เรียงจากด้านที่มีค่าคะแนนมากที่สุดไปน้อยที่สุด

- คะแนนรวม:
  - 0–38 = อาการน้อย
  - 39–67 = อาการปานกลาง
  - 68–179 = อาการรุนแรง

**รูปแบบ JSON ที่ต้องการ (ตัวอย่าง):**
{
  "levelCommunication": "รุนแรง",
  "levelSocial": "ปานกลาง",
  "levelSense": "น้อย",
  "levelHealth": "น้อย",
  "overallLevel": "รุนแรง",
  "summaryCode": "LSCH",
  "explanation": "เด็กมีปัญหาด้านการสื่อสารมากที่สุด รองลงมาคือสังคม ประสาทสัมผัส และสุขภาพ ผู้ปกครองควรให้เด็กฝึกฝนการพูดบ่อยๆ เช่นการพูดในสถานการณ์ต่างๆที่ไม่คุ้นเคยเพื่อสร้างความเคยชิน"
}
''';

    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    final headers = {
      'Authorization':
          'Bearer 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',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "model": "scb10x/llama3.1-typhoon2-70b-instruct",
      "messages": [
        {"role": "system", "content": "คุณคือผู้เชี่ยวชาญด้านแบบทดสอบ ATEC"},
        {"role": "user", "content": prompt},
      ],
      "temperature": 0.7,
      "max_tokens": 512,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      throw Exception("การเชื่อมต่อ API ล้มเหลว: ${response.body}");
    }

    final data = json.decode(response.body);
    return data['choices'][0]['message']['content'];
  }

  void extractResults(String responseText) {
    try {
      final Map<String, dynamic> result = jsonDecode(responseText);

      levelCommunication = result["levelCommunication"] ?? "ไม่พบข้อมูล";
      levelSocial = result["levelSocial"] ?? "ไม่พบข้อมูล";
      levelSense = result["levelSense"] ?? "ไม่พบข้อมูล";
      levelHealth = result["levelHealth"] ?? "ไม่พบข้อมูล";
      overallLevel = result["overallLevel"] ?? "ไม่พบข้อมูล";
      summaryCode = result["summaryCode"] ?? "ไม่พบข้อมูล";
      explanation = result["explanation"] ?? "ไม่พบข้อมูล";
    } catch (e) {
      throw Exception("แยกข้อมูลไม่สำเร็จ: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9C8A87),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(0, 255, 255, 255),
                image: DecorationImage(
                  image: AssetImage('assets/images/head.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '${progress.toInt()}%',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'กำลังประมวลผลผลลัพธ์...',
              style: TextStyle(color: Colors.white70, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
