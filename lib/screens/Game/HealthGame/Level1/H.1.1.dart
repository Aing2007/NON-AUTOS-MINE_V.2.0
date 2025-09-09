import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:non_autos_mine/screens/Game/HealthGame/summaryGameH.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameH.dart';

/// ---------------------------------------------------------------------------
/// FruitHandChoiceGame
/// - ยึดดีไซน์ส่วนหัวและพื้นหลังจากต้นแบบ SelectFruitDragGame
/// - กลไก: ผู้เล่นกดปุ่ม 2 ตัวเลือก (ผลไม้ vs มือ) ตามโจทย์ใน bubble
/// - ข้อมูลต่อข้ออยู่ในรูปแบบ List<Map<String, dynamic>> เช่นเดิม
///   โดยเก็บ: รูปผลไม้โจทย์, จำนวนชิ้น (แสดงไอคอนซ้ำใน bubble), ประโยค TTS,
///   และตัวเลือก 2 ปุ่ม (icon + ว่าถูก/ผิด)
/// - Responsive 100%: ทุกขนาดยึด MediaQuery/constraints คำนวณสัดส่วน
/// ---------------------------------------------------------------------------
class FruitHandChoiceGame extends StatefulWidget {
  const FruitHandChoiceGame({Key? key}) : super(key: key);

  @override
  State<FruitHandChoiceGame> createState() => _FruitHandChoiceGameState();
}

class _FruitHandChoiceGameState extends State<FruitHandChoiceGame>
    with SingleTickerProviderStateMixin {
  int score = 0;
  int currentPage = 0;
  bool isAnimating = false;

  /// ข้อมูลต่อข้อ (แก้ไข/เติมได้ตามด่านจริงของคุณ)
  /// หมายเหตุ: ปรับ paths ให้ตรงกับ assets ของโปรเจกต์คุณ
  final List<Map<String, dynamic>> pages = [
    {
      'questionTts': 'ฉันกินกล้วยไป 3 ลูกแล้วตอนนี้ฉันอิ่มมาก',
      'fruitImage': 'assets/game_assets/prototype/fruit/banana.png',
      'fruitCount': 3,
      'options': [
        {
          'id': 'fruit',
          'icon': 'assets/game_assets/prototype/fruit/banana.png',
          'isCorrect': true,
        },
        {
          'id': 'hand',
          'icon': 'assets/game_assets/prototype/other/stop.png',
          'isCorrect': false,
        },
      ],
    },
    {
      'questionTts': 'สอง. ฉันอยากกินแอปเปิลสองลูก',
      'fruitImage': 'assets/game_assets/prototype/fruit/apple.png',
      'fruitCount': 2,
      'options': [
        {
          'id': 'fruit',
          'icon': 'assets/game_assets/prototype/fruit/apple.png',
          'isCorrect': true,
        },
        {
          'id': 'hand',
          'icon': 'assets/game_assets/prototype/icons/hand.png',
          'isCorrect': false,
        },
      ],
    },
    {
      'questionTts': 'สาม. วันนี้ฉันยังไม่อยากกินผลไม้ ขอหยุดก่อนนะ',
      'fruitImage':
          'assets/game_assets/prototype/fruit/grape.png', // ใช้ภาพใดก็ได้ใน bubble เพื่อความต่อเนื่องของ UI
      'fruitCount': 1,
      'options': [
        {
          'id': 'fruit',
          'icon': 'assets/game_assets/prototype/fruit/grape.png',
          'isCorrect': false,
        },
        {
          'id': 'hand',
          'icon': 'assets/game_assets/prototype/icons/hand.png',
          'isCorrect': true,
        },
      ],
    },
    {
      'questionTts': 'สี่. ฉันอยากกินกีวี่หนึ่งลูก',
      'fruitImage': 'assets/game_assets/prototype/fruit/kiwi.png',
      'fruitCount': 1,
      'options': [
        {
          'id': 'fruit',
          'icon': 'assets/game_assets/prototype/fruit/kiwi.png',
          'isCorrect': true,
        },
        {
          'id': 'hand',
          'icon': 'assets/game_assets/prototype/icons/hand.png',
          'isCorrect': false,
        },
      ],
    },
    {
      'questionTts': 'ห้า. ฉันอยากกินสตรอว์เบอร์รี่สี่ลูก',
      'fruitImage': 'assets/game_assets/prototype/fruit/strawberry.png',
      'fruitCount': 4,
      'options': [
        {
          'id': 'fruit',
          'icon': 'assets/game_assets/prototype/fruit/strawberry.png',
          'isCorrect': true,
        },
        {
          'id': 'hand',
          'icon': 'assets/game_assets/prototype/icons/hand.png',
          'isCorrect': false,
        },
      ],
    },
  ];

  late final AnimationController _tapController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
    lowerBound: 0.95,
    upperBound: 1.0,
    value: 1.0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakCurrent();
      _precacheAllAssets();
    });
  }

  void _speakCurrent() {
    final text = pages[currentPage]['questionTts'] as String;
    TtsService.speak(text, rate: 0.5, pitch: 1.0);
  }

  Future<void> _precacheAllAssets() async {
    for (final p in pages) {
      final fruit = p['fruitImage'] as String?;
      if (fruit != null) {
        // ignore: use_build_context_synchronously
        precacheImage(AssetImage(fruit), context);
      }
      final options = (p['options'] as List).cast<Map<String, dynamic>>();
      for (final o in options) {
        final icon = o['icon'] as String?;
        if (icon != null) {
          // ignore: use_build_context_synchronously
          precacheImage(AssetImage(icon), context);
        }
      }
    }
    // Header/profile
    // ignore: use_build_context_synchronously
    precacheImage(const AssetImage('assets/images/head.png'), context);
    // Background/Character
    // ignore: use_build_context_synchronously
    precacheImage(
      const AssetImage('assets/game_assets/prototype/avatar/fornt.png'),
      context,
    );
  }

  Future<void> _next() async {
    if (currentPage < pages.length - 1) {
      setState(() => currentPage += 1);
      _speakCurrent();
    } else {
      final total = pages.length;
      TtsService.speak(
        'คุณทำคะแนนได้ $score คะแนน จากทั้งหมด $total คะแนน',
        rate: 0.5,
        pitch: 1.0,
      );
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen_H(
            context: context,
            totalScore: score,
            currentLevel: 1,
          ),
        ),
      );
    }
  }

  Future<void> _onChoose(bool isCorrect) async {
    if (isAnimating) return;
    setState(() => isAnimating = true);

    HapticFeedback.lightImpact();
    await _tapController.reverse();
    await _tapController.forward();

    if (isCorrect) {
      setState(() => score += 1);
      // สั่นเพิ่มความรู้สึกตอบถูก
      HapticFeedback.mediumImpact();
    }

    await Future.delayed(const Duration(milliseconds: 220));
    setState(() => isAnimating = false);
    // ไปต่อ
    if (mounted) _next();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final screenH = size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenW,
        height: screenH,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGH.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ---------------- Header (เหมือนต้นแบบ) ----------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: GameHeader(
                  money: '12,000,000.00',
                  profileImage: 'assets/images/head.png',
                ),
              ),

              // ---------------- Progress Bar (เหมือนต้นแบบ) ----------------
              _ProgressBar(current: currentPage + 1, total: pages.length),

              const SizedBox(height: 20),

              // ---------------- Character Area + Bubble ----------------
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxW = constraints.maxWidth;

                    final bubbleMaxWidth = maxW * 0.70; // กว้าง ~70% ของจอ
                    final bubbleIconSize = (maxW * 0.14).clamp(40, 82);

                    return Center(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // การ์ดพื้นหลังโปร่งบาง เหมือนหน้าเดิม

                          // Bubble + Character
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // --- Speech Bubble ---
                              _SpeechBubble(
                                maxWidth: bubbleMaxWidth,
                                child: _FruitRepeatRow(
                                  imagePath:
                                      pages[currentPage]['fruitImage']
                                          as String,
                                  count:
                                      pages[currentPage]['fruitCount'] as int,
                                  iconSize: bubbleIconSize.toDouble(),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // --- Character ---
                              Container(
                                width: maxW * 1.2,
                                height: screenH * 0.5,
                                constraints: const BoxConstraints(
                                  maxWidth: 520,
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      'assets/game_assets/prototype/avatar/fornt.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ---------------- Bottom Choices ----------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: _BottomChoices(
                  isAnimating: isAnimating,
                  options: (pages[currentPage]['options'] as List)
                      .cast<Map<String, dynamic>>(),
                  onTap: (isCorrect) => _onChoose(isCorrect),
                  controller: _tapController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Widgets ----------------

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  const _ProgressBar({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth - 20;
            final iconWidth = 25.0;
            final progress = (current / total) * maxWidth;
            return Stack(
              children: [
                Positioned(
                  top: 9,
                  left: 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: progress,
                    height: 11,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8BC7AD),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                ),
                Positioned(
                  top: 1,
                  left:
                      10 +
                      (progress - iconWidth / 2).clamp(0, maxWidth - iconWidth),
                  child: Container(
                    width: iconWidth,
                    height: 27,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/head.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SpeechBubble extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const _SpeechBubble({required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, minWidth: 180),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: child),
          ),
          // หางคำพูด (สี่เหลี่ยมหมุน 45°)
          Transform.rotate(
            angle: 0.78539816339, // 45 deg in radians
            child: Container(width: 16, height: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _FruitRepeatRow extends StatelessWidget {
  final String imagePath;
  final int count;
  final double iconSize;
  const _FruitRepeatRow({
    required this.imagePath,
    required this.count,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final showCount = count.clamp(0, 6); // จำกัดสูงสุด 6 ไอคอนต่อแถว
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(showCount, (_) {
        return Image.asset(
          imagePath,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          semanticLabel: 'ผลไม้',
        );
      }),
    );
  }
}

class _BottomChoices extends StatelessWidget {
  final bool isAnimating;
  final List<Map<String, dynamic>> options; // ต้องมี 2 ตัวเลือก
  final Future<void> Function(bool isCorrect) onTap;
  final AnimationController controller;

  const _BottomChoices({
    required this.isAnimating,
    required this.options,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final diameter = (constraints.maxWidth * 0.34)
            .clamp(96, 160)
            .toDouble();

        Widget buildButton(Map<String, dynamic> data) {
          final String icon = data['icon'] as String;
          final bool isCorrect = (data['isCorrect'] as bool?) ?? false;

          return ScaleTransition(
            scale: controller,
            child: Semantics(
              button: true,
              label: isCorrect ? 'ตัวเลือกที่ถูกต้อง' : 'ตัวเลือก',
              child: Material(
                color: Colors.white,
                elevation: 4,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: isAnimating ? null : () => onTap(isCorrect),
                  child: SizedBox(
                    width: diameter,
                    height: diameter,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(icon, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: buildButton(options[0]),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: buildButton(options[1]),
              ),
            ),
          ],
        );
      },
    );
  }
}
