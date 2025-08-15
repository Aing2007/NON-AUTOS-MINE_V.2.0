import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'gamemap_screen.dart';

class SummaryPage extends StatefulWidget {
  final String summaryCode;
  final String explanation;
  final String levelCommunication;
  final String levelSocial;
  final String levelSense;
  final String levelHealth;
  final String overallLevel;
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;

  const SummaryPage({
    super.key,
    required this.summaryCode,
    required this.explanation,
    required this.levelCommunication,
    required this.levelSocial,
    required this.levelSense,
    required this.levelHealth,
    required this.overallLevel,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late int score1, score2, score3, score4;
  late int scoreTotal;
  late String testResult;
  late String level;
  late Color pageColor;
  late String summaryCode;

  @override
  void initState() {
    super.initState();

    score1 = widget.score1 ?? 0;
    score2 = widget.score2 ?? 0;
    score3 = widget.score3 ?? 0;
    score4 = widget.score4 ?? 0;

    scoreTotal = score1 + score2 + score3 + score4;

    if (scoreTotal >= 68) {
      testResult = "GROWING COMMUNICATOR";
      level = "3";
    } else if (scoreTotal >= 39) {
      testResult = "LEARNING COMMUNICATOR";
      level = "2";
    } else if (scoreTotal >= 1) {
      testResult = "ACTIVE COMMUNICATOR";
      level = "1";
    } else {
      testResult = "UNKNOWN";
      level = "0";
    }

    // Set pageColor by level
    switch (level) {
      case '1':
        pageColor = const Color(0xFF7F95E4);
        break;
      case '2':
        pageColor = const Color(0xFFFED371);
        break;
      case '3':
        pageColor = const Color(0xFFF65A3B);
        break;
      default:
        pageColor = const Color.fromARGB(255, 144, 144, 144);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      body: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            'AING',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          Image.asset('assets/images/body.png', height: 400),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Level: $level",
              style: TextStyle(
                color: pageColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            testResult,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'คะแนนรวม = $scoreTotal',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildScoreLine(
                  index: 1,
                  title: 'การพูด/ การเปล่งเสียงใช้ภาษา/การสื่อสาร',
                  score: score1,
                ),
                _buildScoreLine(
                  index: 2,
                  title: 'ความสามารถทางสังคม',
                  score: score2,
                ),
                _buildScoreLine(
                  index: 3,
                  title: 'ประสาทสัมผัสรับความรู้สึก และความคิด/การรับรู้',
                  score: score3,
                ),
                _buildScoreLine(
                  index: 4,
                  title: 'สุขภาพ/ ร่างกาย/ พฤติกรรม',
                  score: score4,
                ),
              ],
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        widget.summaryCode,
                        style: TextStyle(
                          color: pageColor,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const SizedBox(height: 64), // เว้นช่องให้ปุ่มไม่ชน
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                right: 32,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MAINHomePage(
                          pageColor: pageColor,
                          level: level,
                          testResult: testResult,
                          score1: score1,
                          score2: score2,
                          score3: score3,
                          score4: score4,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: pageColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: pageColor.withOpacity(0.6),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreLine({
    required int index,
    required String title,
    required int score,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$index. $title = $score',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
