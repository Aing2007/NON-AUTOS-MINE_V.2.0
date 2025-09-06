import 'package:flutter/material.dart';
import 'package:non_autos_mine/screens/Game/CommonGame/Level1/C.1.1.dart';

//import 'package:non_autos_mine/screens/Game/SenceGame/Level1/C.1.1.dart';
//import 'package:non_autos_mine/screens/Game/SenceGame/Level1/C.1.2.dart';
//import 'package:non_autos_mine/screens/Game/SenceGame/Level1/C.1.3.dart';
import 'map_C.dart';

void main() {
  runApp(const STARTCscreen());
}

class STARTCscreen extends StatelessWidget {
  final String number;
  final String page;
  const STARTCscreen({
    super.key,
    this.number = "00",
    this.page = "",
  }); // ✅ เพิ่มพารามิเตอร์ number

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AING App',
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      home: AingHomePage(
        number: number,
        page: page,
      ), // ✅ ส่งค่าไปยัง AingHomePage
      debugShowCheckedModeBanner: false,
    );
  }
}

class AingHomePage extends StatefulWidget {
  final String number;
  final String page;
  const AingHomePage({
    super.key,
    required this.number,
    required this.page,
  }); // ✅ รับค่า number

  @override
  State<AingHomePage> createState() => _AingHomePageState();
}

class _AingHomePageState extends State<AingHomePage>
    with TickerProviderStateMixin {
  late AnimationController _cardAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _buttonScaleAnimation;

  int _heartCount = 100;
  int _currency = 12000000;
  int _currentNumber = 1;

  @override
  void initState() {
    super.initState();
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _cardScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  // Color definitions matching the design
  static const Color appBg = Color(0xFFFAF5EF);
  static const Color appPrimary = Color(0xFFFED371);
  static const Color appAccent = Color(0xFFF65A3B);
  static const Color appLight = Color(0xFFFFE5A9);
  static const Color appText = Color(0xFF5F4A46);
  static const Color appTextLight = Color(0xFF9C8A87);
  static const Color appYellow = Color(0xFFFFD370);

  void _onHeartTap() {
    setState(() {
      _heartCount += 10;
    });
    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
    });
  }

  void _onMainCardTap() {
    _cardAnimationController.forward().then((_) {
      _cardAnimationController.reverse();
    });
    setState(() {
      _currentNumber = _currentNumber < 99 ? _currentNumber + 1 : 1;
    });
  }

  void _onCloseTap() {
    // Handle close action
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;
    final containerWidth = isSmallScreen ? screenWidth * 0.9 : 448.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/GameBG/StartBGC.png"),
            fit: BoxFit.cover, // ✅ ให้ภาพเต็มหน้าจอ
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              width: containerWidth,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isSmallScreen ? 32 : 64,
              ),
              child: Column(
                children: [
                  _buildHeader(isSmallScreen),
                  SizedBox(height: isSmallScreen ? 48 : 96),
                  Expanded(
                    child: _buildMainCard(
                      screenWidth,
                      screenHeight,
                      isSmallScreen,
                      widget.number, // ✅ ใช้ค่าที่ส่งมาแทน "02"
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profile and App Name
        Row(
          children: [
            // Profile Avatar
            Container(
              width: isSmallScreen ? 48 : 56,
              height: isSmallScreen ? 48 : 56,
              decoration: BoxDecoration(
                color: appAccent,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/head.png",
                  ), // ✅ ใส่รูปโปรไฟล์ของคุณ
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      255,
                      66,
                      66,
                    ).withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),

            SizedBox(width: isSmallScreen ? 12 : 16),

            // App Name
            Text(
              'AING',
              style: TextStyle(
                color: appText,
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),

        // Stats Section
        Row(
          children: [
            // Currency
            _buildStatContainer(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _currency.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},',
                    ),
                    style: TextStyle(
                      color: appTextLight,
                      fontSize: isSmallScreen ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: isSmallScreen ? 16 : 20,
                    height: isSmallScreen ? 16 : 20,
                    decoration: const BoxDecoration(
                      color: appYellow,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isSmallScreen: isSmallScreen,
            ),

            SizedBox(width: isSmallScreen ? 8 : 12),

            // Hearts
            GestureDetector(
              onTap: _onHeartTap,
              child: AnimatedBuilder(
                animation: _buttonScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _buttonScaleAnimation.value,
                    child: _buildStatContainer(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _heartCount.toString(),
                            style: TextStyle(
                              color: appTextLight,
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.favorite,
                            color: appAccent,
                            size: isSmallScreen ? 16 : 20,
                          ),
                        ],
                      ),
                      isSmallScreen: isSmallScreen,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: isSmallScreen ? 8 : 12),

            // Close Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MAPCscreen()),
                );
              },
              child: Container(
                width: isSmallScreen ? 36 : 44,
                height: isSmallScreen ? 36 : 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.close,
                  color: appTextLight,
                  size: isSmallScreen ? 18 : 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatContainer({
    required Widget child,
    required bool isSmallScreen,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildMainCard(
    double screenWidth,
    double screenHeight,
    bool isSmallScreen,
    String Number,
  ) {
    final cardHeight = isSmallScreen ? screenHeight * 0.5 : 534.0;

    return AnimatedBuilder(
      animation: _cardScaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _cardScaleAnimation.value,
          child: GestureDetector(
            onTap: _onMainCardTap,
            child: Container(
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Stack(
                children: [
                  // Main Number Display
                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),

                      child: Text(
                        Number, // ✅ ใช้ค่า String ที่รับมา
                        key: ValueKey(
                          Number,
                        ), // ใช้ Number แทน _currentNumber เพื่อให้ AnimatedSwitcher ทำงานถูก
                        style: TextStyle(
                          color: appPrimary,
                          fontSize: isSmallScreen ? 128 : 140,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 24 : 32),
                  // Bottom Actions
                  Positioned(
                    bottom: isSmallScreen ? 60 : 80,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Action Button with Heart
                        GestureDetector(
                          onTap: () {
                            // ✅ เลือกหน้า Navigate ตามค่า page ที่ส่งเข้ามา
                            Widget nextPage = _getPageByNumber(widget.page);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => nextPage),
                            );
                          },
                          child: Container(
                            height: isSmallScreen ? 64 : 80,
                            width: isSmallScreen ? 200 : 240,
                            decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: appPrimary.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chevron_left,
                                  color: appLight,
                                  size: isSmallScreen ? 28 : 36,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '10',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 32 : 40,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.favorite,
                                  color: appLight,
                                  size: isSmallScreen ? 28 : 32,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Close Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const MAPCscreen(), // 👉 ไปยังหน้าใหม่
                              ),
                            );
                          },
                          child: Container(
                            height: isSmallScreen ? 40 : 44,
                            width: isSmallScreen ? 200 : 240,
                            decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: appPrimary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: isSmallScreen ? 18 : 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _getPageByNumber(String page) {
  switch (page) {
    case "1":
      return const common1();
    case "2":
    //return const SelectFruit2();
    case "3":
    //return const SelectFruit3();
    default:
      return const MAPCscreen(); // fallback เผื่อ page ไม่ตรง
  }
}
