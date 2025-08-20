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
    final List<ChartData> chartDataList = [
      ChartData(
        title: "Speech/Language/Communication",
        score: score1,
        scoreDescription: score1_re,
        color: Color(0xFF7F95E4),
        data: List.filled(25, 50),
        description: "ด่านที่ 1-14 การสื่อสาร",
      ),
      ChartData(
        title: "Sociability",
        score: score2,
        scoreDescription: score2_re,
        color: Color(0xFFF65A3B),
        data: List.filled(25, 45),
        description: "ด่านที่ 15-34 การเข้าสังคม",
      ),
      ChartData(
        title: "Sensory/Cognitive Awareness",
        score: score3,
        scoreDescription: score3_re,
        color: Color(0xFFFFD370),
        data: List.filled(25, 70),
        description: "ด่านที่ 35-52 ความรู้สึกและการรับรู้",
      ),
      ChartData(
        title: "Health/Physical/Behavior",
        score: score4,
        scoreDescription: score4_re,
        color: Color(0xFF8BC7AD),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: 32),
                      _buildLevelIndicators(),
                      const SizedBox(height: 16),
                      _buildProgressChart(chartDataList[_selectedChartIndex]),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
            _buildSideIcons(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart(ChartData chartData) {
    return Container(
      decoration: BoxDecoration(
        color: chartData.color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 400, maxHeight: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chartData.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'SCORE : ${chartData.score} (${chartData.scoreDescription})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'กราฟแสดงประสิทธิภาพในการผ่านด่าน',
                    style: TextStyle(
                      color: chartData.color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(11, (i) {
                              return Text(
                                '${(10 - i) * 10}'.padLeft(2, '0'),
                                style: const TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: chartData.data.map((value) {
                              return SizedBox(
                                width: 8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 128,
                                      decoration: BoxDecoration(
                                        color: chartData.color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 8,
                                            height: (128 * value / 100),
                                            decoration: BoxDecoration(
                                              color: chartData.color,
                                              borderRadius:
                                                  BorderRadius.circular(4),
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(25, (index) {
                      return Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: chartData.color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            chartData.description,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: pageColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/ICON.png',
              ), // ✅ เปลี่ยน path ให้ถูกต้อง
              fit: BoxFit.cover, // หรือ BoxFit.contain ตามความต้องการ
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Icon(
          Icons.keyboard_arrow_down,
          color: Color.fromARGB(255, 12, 5, 3),
          size: 16,
        ),
        const SizedBox(height: 16),
        const Text(
          'AING',
          style: TextStyle(
            color: Color(0xFF805E57),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          decoration: BoxDecoration(
            color: pageColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'LEVEL : $level',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'ผลการประเมิน: $testResult',
          style: TextStyle(
            color: pageColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLevelIndicators() {
    final indicators = [
      {'letter': 'L', 'color': Color(0xFF7F95E4), 'height': 80.0, 'index': 0},
      {'letter': 'S', 'color': Color(0xFFF65A3B), 'height': 32.0, 'index': 1},
      {'letter': 'C', 'color': Color(0xFFFFD370), 'height': 104.0, 'index': 2},
      {'letter': 'H', 'color': Color(0xFF8BC7AD), 'height': 88.0, 'index': 3},
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
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((i) {
            return Container(
              width: 40,
              height: 144,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 40,
                  height: i['height'] as double,
                  decoration: BoxDecoration(
                    color: i['color'] as Color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Container(
          height: 48,
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
                      borderRadius: BorderRadius.circular(16),
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

  Widget _buildSideIcons() {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        children: const [
          Icon(Icons.settings, color: Color(0xFF805E57), size: 28),
          SizedBox(height: 24),
          Icon(Icons.notifications, color: Color(0xFF805E57), size: 28),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavButton(
            icon: Icons.home,
            label: 'HOME',
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

  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? Colors.grey, size: 30),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
