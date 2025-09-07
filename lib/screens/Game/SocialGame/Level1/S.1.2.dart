import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameS.dart';

class SelectFruitDragGame extends StatefulWidget {
  const SelectFruitDragGame({Key? key}) : super(key: key);

  @override
  _SelectFruitDragGameState createState() => _SelectFruitDragGameState();
}

class _SelectFruitDragGameState extends State<SelectFruitDragGame> {
  int score = 0;
  int currentPage = 0;
  bool isAnimating = false;

  // ตัวอย่าง data (แทนที่ด้วยของคุณได้เลย)
  final List<Map<String, dynamic>> fruitPages = [
    {
      "question": "1.ฉันอยากกินกล้วยจังเลย",
      "fruits": [
        {
          "id": "banana",
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": true,
        },

        {
          "id": "grape",
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "2.ฉันอยากกินแอปเปิ้ลจังเลย",
      "fruits": [
        {
          "id": "banana",
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },

        {
          "id": "apple",
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "3.ฉันอยากกินองุ่นจังเลย",
      "fruits": [
        {
          "id": "apple",
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },

        {
          "id": "grape",
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "4.ฉันอยากกินกีวี่จังเลย",
      "fruits": [
        {
          "id": "kiwi",
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": true,
        },

        {
          "id": "apple",
          "image": "assets/game_assets/prototype/fruit/apple.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "5.ฉันอยากกินสตรอว์เบอร์รีจังเลย",
      "fruits": [
        {
          "id": "banana",
          "image": "assets/game_assets/prototype/fruit/banana.png",
          "isCorrect": false,
        },

        {
          "id": "strawberry",
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "6.ฉันอยากกินมะพร้าวจังเลย",
      "fruits": [
        {
          "id": "coconut",
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": true,
        },

        {
          "id": "grape",
          "image": "assets/game_assets/prototype/fruit/grab.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "7.ฉันอยากกินเลม่อนจังเลย",
      "fruits": [
        {
          "id": "lemon",
          "image": "assets/game_assets/prototype/fruit/lemon.png",
          "isCorrect": true,
        },

        {
          "id": "strawberry",
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "8.ฉันอยากกินลูกท้อจังเลย",
      "fruits": [
        {
          "id": "kiwi",
          "image": "assets/game_assets/prototype/fruit/kiwi.png",
          "isCorrect": false,
        },

        {
          "id": "peach",
          "image": "assets/game_assets/prototype/fruit/peach.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "9.ฉันอยากกินสัปปะรดจังเลย",
      "fruits": [
        {
          "id": "strawberry",
          "image": "assets/game_assets/prototype/fruit/strawberry.png",
          "isCorrect": false,
        },

        {
          "id": "pineapple",
          "image": "assets/game_assets/prototype/fruit/pineapple.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "10.ฉันอยากกินแตงโมจังเลย",
      "fruits": [
        {
          "id": "watermelon",
          "image": "assets/game_assets/prototype/fruit/watermelon.png",
          "isCorrect": true,
        },

        {
          "id": "coconut",
          "image": "assets/game_assets/prototype/fruit/coconut.png",
          "isCorrect": false,
        },
      ],
    },

    // ... เพิ่มเป็น 10 หน้า
  ];

  // เก็บสถานะว่า tile ถูกใช้แล้ว (เพื่อเล่น animation scale)
  late List<bool> usedTiles;

  @override
  void initState() {
    super.initState();
    _initUsedTiles();
    // อ่านคำถามแรก
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TtsService.speak(
        fruitPages[currentPage]["question"] as String,
        rate: 0.5,
        pitch: 1.0,
      );
      // precache images ถ้าต้องการ
      _precacheAllAssets();
    });
  }

  void _initUsedTiles() {
    final count = (fruitPages[currentPage]["fruits"] as List).length;
    usedTiles = List<bool>.filled(count, false);
  }

  Future<void> _precacheAllAssets() async {
    for (var page in fruitPages) {
      final fruits = page["fruits"] as List;
      for (var f in fruits) {
        final path = f["image"] as String;
        precacheImage(AssetImage(path), context);
      }
    }
    // precache character / header images ถ้ามี
    precacheImage(const AssetImage('assets/images/head.png'), context);
  }

  void _nextQuestion() {
    if (currentPage < fruitPages.length - 1) {
      setState(() {
        currentPage += 1;
        _initUsedTiles();
      });
      TtsService.speak(
        fruitPages[currentPage]["question"] as String,
        rate: 0.5,
        pitch: 1.0,
      );
    } else {
      // จบเกม
      TtsService.speak(
        "คุณทำคะแนนได้ $score คะแนน จากทั้งหมด ${fruitPages.length} คะแนน",
        rate: 0.5,
        pitch: 1.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen_S(
            context: context,
            totalScore: score,
            currentLevel: 2,
          ),
        ),
      );
    }
  }

  Future<void> _handleAccepted(int draggedIndex) async {
    if (isAnimating) return;
    final fruits = fruitPages[currentPage]["fruits"] as List;
    final isCorrect = fruits[draggedIndex]["isCorrect"] as bool;

    setState(() => isAnimating = true);

    if (isCorrect) {
      // เล่น animation หดสำหรับ tile ที่ถูกลาก
      setState(() {
        usedTiles[draggedIndex] = true;
      });

      // รอให้ animation scale/opacity เล่นเสร็จ
      await Future.delayed(const Duration(milliseconds: 350));

      setState(() => score += 1);
      setState(() => isAnimating = false);
      _nextQuestion();
    } else {
      // Feedback ผิด: สั้น ๆ แล้วไปข้อถัดไป
      // (สามารถเล่น sound / haptic / shake widget ได้ที่นี่)
      await Future.delayed(const Duration(milliseconds: 250));
      setState(() => isAnimating = false);
      _nextQuestion();
    }
  }

  Widget _buildDraggableTile(
    int index,
    Map<String, dynamic> fruit,
    double tileSize,
  ) {
    final bool used = usedTiles.length > index ? usedTiles[index] : false;
    final imagePath = fruit["image"] as String;

    return Draggable<int>(
      data: index,
      feedback: SizedBox(
        width: tileSize,
        height: tileSize,
        child: Material(
          color: Colors.transparent,
          child: _fruitTile(imagePath, tileSize, elevation: 8),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.25,
        child: _fruitTile(imagePath, tileSize),
      ),
      maxSimultaneousDrags: isAnimating ? 0 : 1,
      child: AnimatedScale(
        scale: used ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: AnimatedOpacity(
          opacity: used ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: _fruitTile(imagePath, tileSize),
        ),
      ),
    );
  }

  Widget _fruitTile(String assetPath, double size, {double elevation = 2}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: elevation,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final tileSize = screenW * 0.22;

    final currentFruits = fruitPages[currentPage]["fruits"] as List;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenW,
        height: screenH,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGS.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ---------- Header ----------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: GameHeader(
                  money: "12,000,000.00",
                  profileImage: "assets/images/head.png",
                ),
              ),

              // ---------- Progress bar (reuse logic fromต้นแบบ) ----------
              Padding(
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
                      double maxWidth = constraints.maxWidth - 20;
                      double iconWidth = 25;
                      double progress =
                          ((currentPage + 1) / fruitPages.length) * maxWidth;
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
                                color: const Color(0xFFF65A3B),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            left:
                                10 +
                                (progress - iconWidth / 2).clamp(
                                  0,
                                  maxWidth - iconWidth,
                                ),
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
              ),

              const SizedBox(height: 18),

              // ---------- Character area (DragTarget) ----------
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // background card / decorative shapes can be here
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.56,
                      ),

                      // Character image
                      Positioned(
                        top: 40,
                        child: Column(
                          children: [
                            // speech bubble with requested fruit
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Image.asset(
                                (fruitPages[currentPage]["fruits"]
                                        as List)[(fruitPages[currentPage]["fruits"]
                                            as List)
                                        .indexWhere(
                                          (f) => f['isCorrect'] == true,
                                        )]["image"]
                                    as String,
                                width: 64,
                                height: 64,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Character is also the drop target
                            DragTarget<int>(
                              builder: (context, candidateData, rejectedData) {
                                // highlight when hovering
                                final hovering = candidateData.isNotEmpty;
                                return Container(
                                  width: screenW * 1.3,
                                  height: screenW * 1.3,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      0,
                                      255,
                                      255,
                                      255,
                                    ),

                                    border: hovering
                                        ? Border.all(
                                            color: Colors.greenAccent,
                                            width: 3,
                                          )
                                        : null,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/game_assets/prototype/avatar/fornt.png',
                                      fit: BoxFit.contain,
                                    ), // replace with your character image
                                  ),
                                );
                              },
                              onWillAccept: (data) => !isAnimating,
                              onAccept: (draggedIndex) async {
                                await _handleAccepted(draggedIndex);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Bottom card: choices ----------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(currentFruits.length, (i) {
                      final fruit = currentFruits[i] as Map<String, dynamic>;
                      return _buildDraggableTile(i, fruit, tileSize);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
