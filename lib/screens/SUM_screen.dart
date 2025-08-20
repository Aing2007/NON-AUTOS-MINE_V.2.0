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
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double horizontalPadding = width * 0.07;
    final double verticalPadding = height * 0.02;
    final double titleFontSize = width * 0.09;
    final double bodyImageHeight = height * 0.32;
    final double levelFontSize = width * 0.06;
    final double resultFontSize = width * 0.055;
    final double scoreFontSize = width * 0.055;
    final double scoreLineFontSize = width * 0.045;
    final double summaryCodeFontSize = width * 0.13;
    final double arrowButtonSize = width * 0.15;
    final double bottomBarRadius = width * 0.13;

    return Scaffold(
      backgroundColor: pageColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: verticalPadding * 3),
            Text(
              'AING',
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: verticalPadding * 2),
            Image.asset(
              'assets/images/body.png',
              height: bodyImageHeight,
            ),
            SizedBox(height: verticalPadding * 1.2),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding * 0.7,
                horizontal: horizontalPadding * 0.7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(bottomBarRadius * 0.7),
              ),
              child: Text(
                "Level: $level",
                style: TextStyle(
                  color: pageColor,
                  fontWeight: FontWeight.bold,
                  fontSize: levelFontSize,
                ),
              ),
            ),
            SizedBox(height: verticalPadding * 0.8),
            Text(
              testResult,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: resultFontSize,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: verticalPadding * 0.3),
            Text(
              'คะแนนรวม = $scoreTotal',
              style: TextStyle(
                color: Colors.white,
                fontSize: scoreFontSize,
              ),
            ),
            SizedBox(height: verticalPadding * 1.2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScoreLine(
                    index: 1,
                    title: 'การพูด/ การเปล่งเสียงใช้ภาษา/การสื่อสาร',
                    score: score1,
                    fontSize: scoreLineFontSize,
                  ),
                  _buildScoreLine(
                    index: 2,
                    title: 'ความสามารถทางสังคม',
                    score: score2,
                    fontSize: scoreLineFontSize,
                  ),
                  _buildScoreLine(
                    index: 3,
                    title: 'ประสาทสัมผัสรับความรู้สึก และความคิด/การรับรู้',
                    score: score3,
                    fontSize: scoreLineFontSize,
                  ),
                  _buildScoreLine(
                    index: 4,
                    title: 'สุขภาพ/ ร่างกาย/ พฤติกรรม',
                    score: score4,
                    fontSize: scoreLineFontSize,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: verticalPadding * 2,
                    bottom: verticalPadding * 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(bottomBarRadius * 3.7),
                      topRight: Radius.circular(bottomBarRadius * 3.7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: verticalPadding * 0.5),
                        Text(
                          widget.summaryCode,
                          style: TextStyle(
                            color: pageColor,
                            fontSize: summaryCodeFontSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                        SizedBox(height: verticalPadding * 2),
                        SizedBox(height: verticalPadding * 6), // เว้นช่องให้ปุ่มไม่ชน
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: verticalPadding * 2.5,
                  right: horizontalPadding,
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
                      width: arrowButtonSize,
                      height: arrowButtonSize,
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
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: arrowButtonSize * 0.55,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreLine({
    required int index,
    required String title,
    required int score,
    required double fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$index. $title = $score',
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}
