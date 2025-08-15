import 'package:flutter/material.dart';
import '../screens/gamemap_screen.dart';
import '../screens/main_screen.dart';

class DashboardPage extends StatelessWidget {
  final int? score1;
  final int? score2;
  final int? score3;
  final int? score4;

  DashboardPage({Key? key, this.score1, this.score2, this.score3, this.score4})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int score_tt =
        (score1 ?? 0) + (score2 ?? 0) + (score3 ?? 0) + (score4 ?? 0);
    String test_result = "";

    if (score_tt >= 1 && score_tt <= 16) {
      test_result = "ACTIVE_COMMUNICATOR";
    } else if (score_tt >= 17 && score_tt <= 29) {
      test_result = "LEARNING_COMMUNICATOR";
    } else if (score_tt >= 30 && score_tt <= 75) {
      test_result = "GROWING_COMMUNICATOR";
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundYellow,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(score_tt, test_result),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundCream,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 60),
                    child: Column(
                      children: [
                        _buildChartSection(
                          title: 'ด้านการพูด การใช้ภาษาติดต่อสื่อสาร',
                          titleColor: AppColors.green,
                          chartData: _getChartData(7),
                          barColor: AppColors.green,
                          lightBarColor: AppColors.green.withOpacity(0.38),
                          maxWidth: screenWidth * 0.9,
                        ),
                        const SizedBox(height: 32),
                        _buildChartSection(
                          title: 'ด้านความสามารถทางสังคม',
                          titleColor: AppColors.blue,
                          chartData: _getChartData(5),
                          barColor: AppColors.blue,
                          lightBarColor: AppColors.blue.withOpacity(0.27),
                          maxWidth: screenWidth * 0.9,
                        ),
                        const SizedBox(height: 32),
                        _buildChartSection(
                          title: 'ด้านประสาทรับความรู้สึกและการรับรู้',
                          titleColor: AppColors.red,
                          chartData: _getChartData(6),
                          barColor: AppColors.red,
                          lightBarColor: AppColors.red.withOpacity(0.38),
                          maxWidth: screenWidth * 0.9,
                        ),
                        const SizedBox(height: 32),
                        _buildChartSection(
                          title: 'ด้านสุขภาพร่างกายและพฤติกรรม',
                          titleColor: AppColors.brown,
                          chartData: _getChartData(8),
                          barColor: AppColors.brown,
                          lightBarColor: AppColors.brown.withOpacity(0.38),
                          maxWidth: screenWidth * 0.9,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(int score_tt, String test_result) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LSCH',
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                    height: 1.0,
                    fontFamily: 'Baloo Tammudu',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'SUTINAN SRIVISET',
                  style: TextStyle(
                    color: AppColors.brown,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Khula',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'LEVEL 12',
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontFamily: 'Khula',
                  ),
                ),

                // ✅ เพิ่มข้อมูล score แยกออกมาตรงนี้
                Text('Score 1: ${score1 ?? 0}'),
                Text('Score 2: ${score2 ?? 0}'),
                Text('Score 3: ${score3 ?? 0}'),
                Text('Score 4: ${score4 ?? 0}'),
                Text('รวมคะแนน: $score_tt'),
                Text('ผลการประเมิน: $test_result'),

                const SizedBox(height: 16),
                const Icon(Icons.menu_book, color: AppColors.blue, size: 24),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.asset(
                'assets/images/ICON.png', // เปลี่ยนเป็น path รูปของคุณ
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required Color titleColor,
    required List<ChartDataPoint> chartData,
    required Color barColor,
    required Color lightBarColor,
    required double maxWidth,
  }) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: _buildChart(chartData, barColor, lightBarColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(
    List<ChartDataPoint> data,
    Color barColor,
    Color lightBarColor,
  ) {
    return SizedBox(
      height: 208,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((point) {
          final heightPercentage = point.value / 90.0;
          final barHeight = heightPercentage * 144;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: barHeight,
                  width: 16, // Increased width
                  decoration: BoxDecoration(
                    color: point.highlighted ? barColor : lightBarColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  point.label,
                  style: TextStyle(
                    color: point.highlighted ? barColor : Colors.grey,
                    fontSize: 12,
                    fontWeight: point.highlighted
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
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
            isActive: false, // ไม่ต้องใช้สีจาก isActive
            iconColor: Colors.grey, // ✅ กำหนดสีไอคอน
            labelColor: Colors.grey, // ✅ กำหนดสีข้อความ
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
            isActive: false, // ไม่ต้องใช้สีจาก isActive
            iconColor: Colors.grey, // ✅ กำหนดสีไอคอน
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
            isActive: false, // ไม่ต้องใช้สีจาก isActive
            iconColor: Colors.blue, // ✅ กำหนดสีไอคอน
            labelColor: Colors.blue, // ✅ กำหนดสีข้อความ
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

  List<ChartDataPoint> _getChartData(int highlightIndex) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return List.generate(
      12,
      (i) => ChartDataPoint(
        months[i],
        (i * 7 + 20) % 90,
        months[i],
        highlighted: i == highlightIndex,
      ),
    );
  }
}

class ChartDataPoint {
  final String month;
  final double value;
  final String label;
  final bool highlighted;

  ChartDataPoint(
    this.month,
    this.value,
    this.label, {
    this.highlighted = false,
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

class AppColors {
  static const backgroundYellow = Color(0xFFFFD370);
  static const backgroundCream = Color(0xFAFAF5EF);
  static const red = Color(0xFFF65A3B);
  static const green = Color(0xFF8BC7AD);
  static const blue = Color(0xFF7F95E4);
  static const brown = Color(0xFF5F4A46);
}
