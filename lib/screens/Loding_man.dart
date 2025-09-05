import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/SUM_screen.dart';

class LoadingManPage extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;

  const LoadingManPage({
    Key? key,
    required this.score1,
    required this.score2,
    required this.score3,
    required this.score4,
  }) : super(key: key);

  @override
  _LoadingAnalysisPageState createState() => _LoadingAnalysisPageState();
}

class _LoadingAnalysisPageState extends State<LoadingManPage> {
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
      localAnalysis(); // ✅ ใช้การวิเคราะห์ภายใน ไม่เรียก API

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

  void localAnalysis() {
    final int s1 = widget.score1 ?? 0;
    final int s2 = widget.score2 ?? 0;
    final int s3 = widget.score3 ?? 0;
    final int s4 = widget.score4 ?? 0;
    final int total = s1 + s2 + s3 + s4;

    // เกณฑ์สูงสุดของแต่ละด้าน
    const max1 = 28; // Communication
    const max2 = 40; // Social
    const max3 = 36; // Sense
    const max4 = 75; // Health

    // อัตราส่วน (ความรุนแรงเทียบกับสูงสุด)
    final ratios = {
      "L": s1 / max1,
      "S": s2 / max2,
      "C": s3 / max3,
      "H": s4 / max4,
    };

    // จัดเรียงตามค่ามาก -> น้อย
    final sortedKeys = ratios.keys.toList()
      ..sort((a, b) => ratios[b]!.compareTo(ratios[a]!));
    summaryCode = sortedKeys.join();

    // วิเคราะห์ระดับแต่ละด้าน
    levelCommunication = s1 <= 5 ? "น้อย" : (s1 <= 14 ? "ปานกลาง" : "รุนแรง");
    levelSocial = s2 <= 11 ? "น้อย" : (s2 <= 16 ? "ปานกลาง" : "รุนแรง");
    levelSense = s3 <= 8 ? "น้อย" : (s3 <= 15 ? "ปานกลาง" : "รุนแรง");
    levelHealth = s4 <= 16 ? "น้อย" : (s4 <= 29 ? "ปานกลาง" : "รุนแรง");

    overallLevel = total <= 38
        ? "อาการน้อย"
        : (total <= 67 ? "อาการปานกลาง" : "อาการรุนแรง");

    // สร้าง explanation
    explanation =
        "จากการประเมินพบว่าด้านที่มีความรุนแรงมากที่สุดคือ ${_mapCode(sortedKeys[0])} "
        "รองลงมาคือ ${_mapCode(sortedKeys[1])}, ${_mapCode(sortedKeys[2])}, และ ${_mapCode(sortedKeys[3])}. "
        "ผู้ปกครองควรให้การดูแลโดยเน้นที่ด้าน ${_mapCode(sortedKeys[0])} เป็นหลัก "
        "และเสริมการฝึกฝนในด้านอื่นๆ ควบคู่กันไป.";
  }

  String _mapCode(String code) {
    switch (code) {
      case "L":
        return "การสื่อสาร";
      case "S":
        return "การเข้าสังคม";
      case "C":
        return "การรับรู้ประสาทสัมผัส";
      case "H":
        return "สุขภาพและพฤติกรรม";
      default:
        return "";
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
