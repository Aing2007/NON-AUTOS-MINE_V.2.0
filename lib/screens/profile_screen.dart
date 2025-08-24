import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'gamemap_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AING - Growing Communicator',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      debugShowCheckedModeBanner: false,
      home: DashboardPage(score1: 6, score2: 5, score3: 8, score4: 9),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;
  final String? level;
  final String? testResult;
  final Color? pageColor;

  const DashboardPage({
    Key? key,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
    this.level,
    this.testResult,
    this.pageColor,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedChartIndex = 3;
  late int score1;
  late int score2;
  late int score3;
  late int score4;
  late int score_tt;

  late String level;
  late String score1_re;
  late String score2_re;
  late String score3_re;
  late String score4_re;
  late Color pageColor;
  late String testResult;
  late String summaryCode;

  @override
  void initState() {
    super.initState();

    score1 = widget.score1 ?? 0;
    score2 = widget.score2 ?? 0;
    score3 = widget.score3 ?? 0;
    score4 = widget.score4 ?? 0;
    pageColor = widget.pageColor ?? const Color(0xFF805E57);
    level = widget.level ?? 'ไม่ระบุ';
    testResult = widget.testResult ?? 'ไม่พบผลลัพธ์';
    if (score1 >= 15) {
      score1_re = "อาการมาก";
    } else if (score1 >= 6 && score1 <= 14) {
      score1_re = "อาการปานกลาง";
    } else {
      score1_re = "อาการน้อย";
    }

    if (score2 >= 17) {
      score2_re = "อาการมาก";
    } else if (score2 >= 12 && score2 <= 16) {
      score2_re = "อาการปานกลาง";
    } else {
      score2_re = "อาการน้อย";
    }

    if (score3 >= 16) {
      score3_re = "อาการมาก";
    } else if (score3 >= 9 && score3 <= 15) {
      score3_re = "อาการปานกลาง";
    } else {
      score3_re = "อาการน้อย";
    }

    if (score4 >= 30) {
      score4_re = "อาการมาก";
    } else if (score4 >= 17 && score4 <= 29) {
      score4_re = "อาการปานกลาง";
    } else {
      score4_re = "อาการน้อย";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final double horizontalPadding = width * 0.04;
    final double verticalPadding = height * 0.03;
    final double avatarSize = width * 0.32;
    final double iconSize = width * 0.09;
    final double chartFontSize = width * 0.045;
    final double chartTitleFontSize = width * 0.055;
    final double chartScoreFontSize = width * 0.045;
    final double chartDescFontSize = width * 0.035;
    final double indicatorFontSize = width * 0.09;
    final double indicatorBarWidth = width * 0.13;
    final double indicatorBarHeight = height * 0.13;
    final double indicatorBarRadius = width * 0.05;
    final double bottomBarHeight = height * 0.10;
    final double bottomBarRadius = width * 0.07;

    final List<ChartData> chartDataList = [
      ChartData(
        title: "Speech/Language/Communication",
        score: score1,
        scoreDescription: score1_re,
        color: const Color(0xFF7F95E4),
        data: List.filled(25, 50),
        description: "ด่านที่ 1-14 การสื่อสาร",
      ),
      ChartData(
        title: "Sociability",
        score: score2,
        scoreDescription: score2_re,
        color: const Color(0xFFF65A3B),
        data: List.filled(25, 45),
        description: "ด่านที่ 15-34 การเข้าสังคม",
      ),
      ChartData(
        title: "Sensory/Cognitive Awareness",
        score: score3,
        scoreDescription: score3_re,
        color: const Color(0xFFFFD370),
        data: List.filled(25, 70),
        description: "ด่านที่ 35-52 ความรู้สึกและการรับรู้",
      ),
      ChartData(
        title: "Health/Physical/Behavior",
        score: score4,
        scoreDescription: score4_re,
        color: const Color(0xFF8BC7AD),
        data: List.filled(25, 60),
        description: "ด่านที่ 53-77 ด้านสุขภาพ ร่างกาย และพฤติกรรม",
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EF),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding * 1.5,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width * 0.95),
                  child: Column(
                    children: [
                      _buildProfileSection(
                        avatarSize: avatarSize,
                        indicatorFontSize: indicatorFontSize,
                        indicatorBarWidth: indicatorBarWidth,
                        indicatorBarHeight: indicatorBarHeight,
                        indicatorBarRadius: indicatorBarRadius,
                        verticalPadding: verticalPadding,
                        pageColor: pageColor,
                        level: level,
                        testResult: testResult,
                      ),
                      SizedBox(height: verticalPadding * 2),
                      _buildLevelIndicators(
                        indicatorFontSize: indicatorFontSize,
                        indicatorBarWidth: indicatorBarWidth,
                        indicatorBarHeight: indicatorBarHeight,
                        indicatorBarRadius: indicatorBarRadius,
                        verticalPadding: verticalPadding,
                      ),
                      SizedBox(height: verticalPadding * 1.2),
                      _buildProgressChart(
                        chartDataList[_selectedChartIndex],
                        chartFontSize: chartFontSize,
                        chartTitleFontSize: chartTitleFontSize,
                        chartScoreFontSize: chartScoreFontSize,
                        chartDescFontSize: chartDescFontSize,
                        width: width,
                      ),
                      SizedBox(height: bottomBarHeight * 1.2),
                    ],
                  ),
                ),
              ),
            ),
            //_buildSideIcons(iconSize: iconSize, verticalPadding: verticalPadding),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigation(
                bottomBarHeight: bottomBarHeight,
                bottomBarRadius: bottomBarRadius,
                iconSize: iconSize,
                width: width,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection({
    required double avatarSize,
    required double indicatorFontSize,
    required double indicatorBarWidth,
    required double indicatorBarHeight,
    required double indicatorBarRadius,
    required double verticalPadding,
    required Color pageColor,
    required String level,
    required String testResult,
  }) {
    return Column(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: pageColor, width: avatarSize * 0.03),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: avatarSize * 0.07,
                offset: Offset(0, avatarSize * 0.03),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/ICON.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: verticalPadding * 0.5),
        Icon(
          Icons.keyboard_arrow_down,
          color: const Color.fromARGB(255, 12, 5, 3),
          size: indicatorFontSize * 0.5,
        ),
        SizedBox(height: verticalPadding * 1.2),
        Text(
          'AING',
          style: TextStyle(
            color: pageColor,
            fontSize: indicatorFontSize * 0.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: verticalPadding * 0.5),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: indicatorBarWidth * 0.7,
            vertical: verticalPadding * 0.5,
          ),
          decoration: BoxDecoration(
            color: pageColor,
            borderRadius: BorderRadius.circular(indicatorBarRadius * 2),
          ),
          child: Text(
            'LEVEL : $level',
            style: TextStyle(
              color: Colors.white,
              fontSize: indicatorFontSize * 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: verticalPadding * 1.2),
        Text(
          'ผลการประเมิน: $testResult',
          style: TextStyle(
            color: pageColor,
            fontSize: indicatorFontSize * 0.7,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLevelIndicators({
    required double indicatorFontSize,
    required double indicatorBarWidth,
    required double indicatorBarHeight,
    required double indicatorBarRadius,
    required double verticalPadding,
  }) {
    final indicators = [
      {'letter': 'L', 'color': const Color(0xFF7F95E4), 'height': indicatorBarHeight * 0.6, 'index': 0},
      {'letter': 'S', 'color': const Color(0xFFF65A3B), 'height': indicatorBarHeight * 0.24, 'index': 1},
      {'letter': 'C', 'color': const Color(0xFFFFD370), 'height': indicatorBarHeight * 0.78, 'index': 2},
      {'letter': 'H', 'color': const Color(0xFF8BC7AD), 'height': indicatorBarHeight * 0.66, 'index': 3},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((i) {
            return Text(
              i['letter'] as String,
              style: TextStyle(
                color: i['color'] as Color,
                fontSize: indicatorFontSize,
                fontWeight: FontWeight.w800,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: verticalPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((i) {
            return Container(
              width: indicatorBarWidth,
              height: indicatorBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(indicatorBarRadius),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: indicatorBarWidth,
                  height: i['height'] as double,
                  decoration: BoxDecoration(
                    color: i['color'] as Color,
                    borderRadius: BorderRadius.circular(indicatorBarRadius),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: verticalPadding),
        Container(
          height: verticalPadding * 2.5,
          child: Row(
            children: indicators.map((i) {
              int index = i['index'] as int;
              Color color = i['color'] as Color;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedChartIndex = index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedChartIndex == index
                          ? color
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(indicatorBarRadius),
                    ),
                    child: const Center(),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart(
    ChartData chartData, {
    required double chartFontSize,
    required double chartTitleFontSize,
    required double chartScoreFontSize,
    required double chartDescFontSize,
    required double width,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: chartData.color,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      padding: EdgeInsets.all(width * 0.04),
      constraints: BoxConstraints(
        minHeight: width * 1.1,
        maxHeight: width * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chartData.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: chartTitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: chartFontSize * 0.2),
          Text(
            'SCORE : ${chartData.score} (${chartData.scoreDescription})',
            style: TextStyle(
              color: Colors.white,
              fontSize: chartScoreFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: chartFontSize * 0.6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
                  Text(
                    'กราฟแสดงประสิทธิภาพในการผ่านด่าน',
                    style: TextStyle(
                      color: chartData.color,
                      fontSize: chartFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: chartFontSize * 0.6),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: chartFontSize * 2.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(11, (i) {
                              return Text(
                                '${(10 - i) * 10}'.padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: chartFontSize * 0.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(width: chartFontSize * 0.7),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: chartData.data.map((value) {
                              return SizedBox(
                                width: chartFontSize* 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: chartFontSize * 0.7,
                                      height: chartFontSize * 3.2,
                                      decoration: BoxDecoration(
                                        color: chartData.color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(chartFontSize * 0.35),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: chartFontSize * 0.7,
                                            height: (chartFontSize * 3.2 * value / 100),
                                            decoration: BoxDecoration(
                                              color: chartData.color,
                                              borderRadius: BorderRadius.circular(chartFontSize * 0.35),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: chartFontSize * 0.6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(25, (index) {
                      return Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: chartData.color,
                          fontSize: chartDescFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: chartFontSize * 0.6),
          Text(
            chartData.description,
            style: TextStyle(
              fontSize: chartDescFontSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  //Widget _buildSideIcons({required double iconSize, required double verticalPadding}) {
    //return Positioned(
      //top: verticalPadding,
      //right: verticalPadding,
      //child: Column(
      //  children: [
      //    Icon(Icons.settings, color: const Color(0xFF805E57), size: iconSize),
      //    SizedBox(height: verticalPadding * 1.5),
      //    Icon(Icons.notifications, color: const Color(0xFF805E57), size: iconSize),
      //  ],
      //),
    //);
 // }

  Widget _buildBottomNavigation({
    required double bottomBarHeight,
    required double bottomBarRadius,
    required double iconSize,
    required double width,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomBarRadius * 3.4),
          topRight: Radius.circular(bottomBarRadius * 3.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: bottomBarHeight * 0.12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavButton(
            icon: Icons.home,
            label: 'HOME',
            iconSize: iconSize,
            fontSize: width * 0.035,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MAINHomePage(
                    pageColor: widget.pageColor,
                    level: widget.level,
                    testResult: widget.testResult,
                    score1: widget.score1,
                    score2: widget.score2,
                    score3: widget.score3,
                    score4: widget.score4,
                  ),
                ),
              );
            },
          ),
          _BottomNavButton(
            icon: Icons.games,
            label: 'GAME',
            iconSize: iconSize,
            fontSize: width * 0.035,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameMapScreen(
                    pageColor: widget.pageColor,
                    level: widget.level,
                    testResult: widget.testResult,
                    score1: widget.score1,
                    score2: widget.score2,
                    score3: widget.score3,
                    score4: widget.score4,
                  ),
                ),
              );
            },
          ),
          _BottomNavButton(
            icon: Icons.person,
            label: 'PROFILE',
            iconColor: Colors.blue,
            labelColor: Colors.blue,
            iconSize: iconSize,
            fontSize: width * 0.035,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String title;
  final int score;
  final String scoreDescription;
  final Color color;
  final List<int> data;
  final String description;

  ChartData({
    required this.title,
    required this.score,
    required this.scoreDescription,
    required this.color,
    required this.data,
    required this.description,
  });
}

class _BottomNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;
  final double? iconSize;
  final double? fontSize;

  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? Colors.grey, size: iconSize ?? 30),
          SizedBox(height: (fontSize ?? 12) * 0.33),
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.grey,
              fontSize: fontSize ?? 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
