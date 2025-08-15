import 'package:flutter/material.dart';
import '../screens/gamemap_screen.dart';
import '../screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

/// แอปหลัก
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AING - Growing Communicator',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// หน้าโฮมหลักที่รองรับ responsive layout
class DashboardPage extends StatefulWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;

  const DashboardPage({
    Key? key,
    this.score1,
    this.score2,
    this.score3,
    this.score4,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // เลข index ของกราฟที่เลือก (0-4)
  int _selectedChartIndex = 3; // เริ่มต้นเลือก Health (index 3)
  late int score_tt;
  late String test_result;
  @override
  void initState() {
    super.initState();

    score_tt =
        (widget.score1 ?? 0) +
        (widget.score2 ?? 0) +
        (widget.score3 ?? 0) +
        (widget.score4 ?? 0);

    if (score_tt >= 1 && score_tt <= 16) {
      test_result = "ACTIVE_COMMUNICATOR";
    } else if (score_tt >= 17 && score_tt <= 29) {
      test_result = "LEARNING_COMMUNICATOR";
    } else if (score_tt >= 30 && score_tt <= 75) {
      test_result = "GROWING_COMMUNICATOR";
    } else {
      test_result = "UNKNOWN";
    }
  }

  // รายการข้อมูลกราฟทั้ง 5 หมวด
  final List<ChartData> _chartDataList = [
    ChartData(
      title: "Language",
      score: 7,
      scoreDescription: "อาการน้อย",
      color: Color(0xFF7F95E4), // สีน้ำเงิน
      data: [
        35,
        47,
        37,
        52,
        29,
        38,
        52,
        29,
        40,
        26,
        39,
        33,
        40,
        19,
        12,
        40,
        28,
        59,
        6,
        59,
        23,
        22,
        38,
        29,
        49,
      ],
      description: "ด่านที่ 1 - 25 ภาษา",
    ),
    ChartData(
      title: "Social",
      score: 5,
      scoreDescription: "อาการน้อย",
      color: Color(0xFFF65A3B), // สีส้มแดง (coral)
      data: [
        25,
        37,
        27,
        42,
        19,
        28,
        42,
        19,
        30,
        16,
        29,
        23,
        30,
        9,
        2,
        30,
        18,
        49,
        0,
        49,
        13,
        12,
        28,
        19,
        39,
      ],
      description: "ด่านที่ 1 - 25 สังคม",
    ),
    ChartData(
      title: "Cognitive",
      score: 8,
      scoreDescription: "อาการน้อย",
      color: Color(0xFFFFD370), // สีเหลือง
      data: [
        55,
        77,
        67,
        92,
        49,
        68,
        92,
        49,
        70,
        46,
        59,
        53,
        70,
        39,
        32,
        70,
        58,
        89,
        26,
        89,
        43,
        42,
        68,
        49,
        79,
      ],
      description: "ด่านที่ 1 - 25 การรู้คิด",
    ),
    ChartData(
      title: "Health/Physical/Behavior",
      score: 9,
      scoreDescription: "อาการน้อย",
      color: Color(0xFF8BC7AD), // สีเขียว
      data: [
        45,
        67,
        57,
        82,
        39,
        58,
        82,
        39,
        60,
        36,
        49,
        43,
        60,
        29,
        22,
        60,
        48,
        79,
        16,
        79,
        33,
        32,
        58,
        39,
        69,
      ],
      description: "ด่านที่ 1 - 25 สุขภาพ ร่างกาย",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF5EF), // สีพื้นหลังครีม
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isTablet = constraints.maxWidth > 600;
            bool isDesktop = constraints.maxWidth > 900;

            if (isDesktop) {
              return _buildDesktopLayout();
            } else if (isTablet) {
              return _buildTabletLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  // ====================== Layout สำหรับมือถือ ========================
  Widget _buildMobileLayout() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              _buildProfileSection(),
              SizedBox(height: 32),
              _buildLevelIndicators(), // แถบสี 5 สีเป็นปุ่ม
              SizedBox(height: 16),
              _buildProgressChart(_chartDataList[_selectedChartIndex]),
              SizedBox(height: 100), // ช่องว่างให้ bottom navigation
            ],
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
    );
  }

  // ====================== Layout สำหรับแท็บเล็ต ========================
  Widget _buildTabletLayout() {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildProfileSection(),
                    SizedBox(height: 32),
                    _buildLevelIndicators(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProgressChart(
                        _chartDataList[_selectedChartIndex],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildSideIcons(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomNavigation(),
        ),
      ],
    );
  }

  // ====================== Layout สำหรับเดสก์ท็อป ========================
  Widget _buildDesktopLayout() {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: 300,
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  _buildProfileSection(),
                  SizedBox(height: 48),
                  _buildLevelIndicators(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Expanded(
                      child: _buildProgressChart(
                        _chartDataList[_selectedChartIndex],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildSideIcons(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomNavigation(),
        ),
      ],
    );
  }

  // ====================== Profile Section ========================
  Widget _buildProfileSection() {
    return Column(
      children: [
        // Avatar รูปวงกลม มีกรอบ
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: Color(0xFFF65A3B),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/ICON.png', // ใส่ path รูปของคุณตรงนี้
              fit: BoxFit.cover,
            ),
          ),
        ),

        // ลูกศรลง
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFF65A3B),
            size: 16,
          ),
        ),

        SizedBox(height: 16),

        // ชื่อ
        Text(
          'AING',
          style: TextStyle(
            color: Color(0xFF805E57),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8),

        // ป้าย Level
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFF65A3B),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            'LEVEL : $test_result',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),

        SizedBox(height: 16),

        // ชื่อเต็ม
        Text(
          'ผลการประเมิน: $test_result',
          style: TextStyle(
            color: Color(0xFFF65A3B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ====================== แถบสี 5 สี พร้อมปุ่ม ========================
  Widget _buildLevelIndicators() {
    final indicators = [
      {
        'letter': 'L',
        'color': Color(0xFF7F95E4),
        'height': 80.0,
        'index': 0,
      }, // Language
      {
        'letter': 'S',
        'color': Color(0xFFF65A3B),
        'height': 32.0,
        'index': 1,
      }, // Social
      {
        'letter': 'C',
        'color': Color(0xFFFFD370),
        'height': 104.0,
        'index': 2,
      }, // Cognitive
      {
        'letter': 'H',
        'color': Color(0xFF8BC7AD),
        'height': 88.0,
        'index': 3,
      }, // Health
    ];

    return Column(
      children: [
        // ตัวอักษร L S C H M
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((indicator) {
            return Text(
              indicator['letter'] as String,
              style: TextStyle(
                color: indicator['color'] as Color,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // แถบ progress bar (สีขาวพื้นหลัง + สีด้านใน)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: indicators.map((indicator) {
            return Container(
              width: 40,
              height: 144,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 40,
                    height: indicator['height'] as double,
                    decoration: BoxDecoration(
                      color: indicator['color'] as Color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // แถบสี 5 สี เป็นปุ่มกดเปลี่ยนกราฟและสีพื้นหลัง
        Container(
          height: 48,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: indicators.map((indicator) {
              int index = indicator['index'] as int;
              Color color = indicator['color'] as Color;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    // เมื่อกดแท็บนี้ เปลี่ยนกราฟที่แสดง และสีพื้นหลัง
                    setState(() {
                      _selectedChartIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedChartIndex == index
                          ? color
                          : Colors.transparent,
                      borderRadius: _getBorderRadiusForTab(
                        index,
                        indicators.length,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        indicator['letter'] as String,
                        style: TextStyle(
                          color: _selectedChartIndex == index
                              ? Colors.white
                              : color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// ช่วยกำหนดมุมโค้งสำหรับแถบสี 5 สี (ซ้ายสุดและขวาสุดโค้ง)
  BorderRadius _getBorderRadiusForTab(int index, int total) {
    if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      );
    } else if (index == total - 1) {
      return BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    }
    return BorderRadius.zero;
  }

  // ====================== แสดงกราฟพร้อมเปลี่ยนสีพื้นหลัง ========================
  Widget _buildProgressChart(ChartData chartData) {
    return Container(
      decoration: BoxDecoration(
        color: chartData.color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      height: 400, // กำหนดสูงคงที่เพื่อให้กราฟไม่ยุบเวลาบนมือถือ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ชื่อกราฟ
          Text(
            chartData.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          // คะแนน + คำอธิบายคะแนน
          Text(
            'SCORE : ${chartData.score} (${chartData.scoreDescription})',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          // กราฟแท่ง
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // ชื่อกราฟย่อย
                  Text(
                    'กราฟแสดงประสิทธิภาพในการผ่านด่าน',
                    style: TextStyle(
                      color: chartData.color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // แถบแท่งกราฟ
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // แกน Y
                        Container(
                          width: 30,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children:
                                [
                                  '100',
                                  '90',
                                  '80',
                                  '70',
                                  '60',
                                  '50',
                                  '40',
                                  '30',
                                  '20',
                                  '10',
                                  '00',
                                ].map((label) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 7,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                        SizedBox(width: 8),
                        // แถบแท่งกราฟแท่งย่อย
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: chartData.data.map((value) {
                              return Container(
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
                  SizedBox(height: 16),
                  // แกน X
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

          SizedBox(height: 16),

          // คำอธิบายกราฟใต้สุด
          Text(
            chartData.description,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ====================== ไอคอนด้านข้างบนสุด ========================
  Widget _buildSideIcons() {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        children: [
          Icon(Icons.settings, color: Color(0xFF805E57), size: 28),
          SizedBox(height: 24),
          Icon(Icons.notifications, color: Color(0xFF805E57), size: 28),
        ],
      ),
    );
  }

  // ====================== Bottom navigation bar (แบบเล็กบนมือถือ) ========================

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
            isActive: false, // ไม่ใช้สีจาก isActive
            iconColor: Colors.grey, // กำหนดสีไอคอน
            labelColor: Colors.grey, // กำหนดสีข้อความ
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MAINHomePage()),
              );
            },
          ),
          _BottomNavButton(
            icon: Icons.games,
            label: 'GAME',
            isActive: false,
            iconColor: Colors.grey,
            labelColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GameMapScreen()),
              );
            },
          ),
          _BottomNavButton(
            icon: Icons.person,
            label: 'PROFILE',
            isActive: false,
            iconColor: Colors.blue,
            labelColor: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DashboardPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// โมเดลข้อมูลกราฟ
class ChartData {
  final String title; // ชื่อหัวข้อ
  final int score; // คะแนน
  final String scoreDescription; // คำอธิบายคะแนน (เช่น อาการน้อย)
  final Color color; // สีหลักของกราฟและพื้นหลัง
  final List<int> data; // ค่าข้อมูลกราฟ (0-100)
  final String description; // คำอธิบายใต้กราฟ

  ChartData({
    required this.title,
    required this.score,
    required this.scoreDescription,
    required this.color,
    required this.data,
    required this.description,
  });
}

class _BottomNavButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _BottomNavButton({
    Key? key,
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  }) : super(key: key);

  @override
  State<_BottomNavButton> createState() => _BottomNavButtonState(); // ✅ อย่าลืม createState()
}

class _BottomNavButtonState extends State<_BottomNavButton> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.9);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color:
                  widget.iconColor ??
                  (widget.isActive ? Colors.blue : Colors.grey),
              size: 30,
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color:
                    widget.labelColor ??
                    (widget.isActive ? Colors.blue : Colors.grey),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
