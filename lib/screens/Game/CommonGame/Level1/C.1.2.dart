import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameC.dart';

class ColorFruitGame extends StatefulWidget {
  const ColorFruitGame({Key? key}) : super(key: key);

  @override
  State<ColorFruitGame> createState() => _ColorFruitGameState();
}

class _ColorFruitGameState extends State<ColorFruitGame> {
  int score = 0;
  int currentPage = 0;
  bool showColor = false;

  final List<Map<String, dynamic>> fruitPages = [
    {
      "question": "1.กล้วยมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/banana(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/banana.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/v.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/other/y.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "2.แอปเปิ้ลมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/apple(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/apple.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/r.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/other/b.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "3.องุ่นมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/grab(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/grab.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/v.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/other/y.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "4.กีวี่มีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/kiwi(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/kiwi.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/g.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/other/p.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "5.สตรอว์เบอร์รีมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/strawberry(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/strawberry.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/brown.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/other/r.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "6.มะพร้าวมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/coconut(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/coconut.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/v.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/other/brown.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "7.เลมอนมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/lemon(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/lemon.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/b.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/other/y.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "8.ลูกท้อมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/peach(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/peach.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/p.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/other/g.png",
          "isCorrect": false,
        },
      ],
    },
    {
      "question": "9.สัปปะรดมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/pineapple(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/pineapple.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/v.png",
          "isCorrect": false,
        },
        {
          "image": "assets/game_assets/prototype/other/y.png",
          "isCorrect": true,
        },
      ],
    },
    {
      "question": "10.แตงโมมีสีอะไรกันนะ ลองจินตนาการดูสิ",
      "imageBW": "assets/game_assets/prototype/fruit/watermelon(B).png",
      "imageColor": "assets/game_assets/prototype/fruit/watermelon.png",
      "options": [
        {
          "image": "assets/game_assets/prototype/other/r.png",
          "isCorrect": true,
        },
        {
          "image": "assets/game_assets/prototype/other/g.png",
          "isCorrect": false,
        },
      ],
    },
    // TODO: เพิ่มข้อที่เหลือ
  ];

  late int totalPages = fruitPages.length;

  @override
  void initState() {
    super.initState();
    TtsService.speak(
      fruitPages[0]["question"] as String,
      rate: 0.5,
      pitch: 1.0,
    );
  }

  void _handleAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() => score += 1);
    }

    if (currentPage < fruitPages.length - 1) {
      setState(() {
        currentPage += 1;
        showColor = false;
        if (fruitPages[currentPage].containsKey("question")) {
          TtsService.speak(
            fruitPages[currentPage]["question"] as String,
            rate: 0.5,
            pitch: 1.0,
          );
        }
      });
    } else {
      TtsService.speak(
        "คุณทำคะแนนได้ $score คะแนน จากทั้งหมด $totalPages คะแนน",
        rate: 0.5,
        pitch: 1.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen_C(
            context: context,
            totalScore: score,
            currentLevel: 2,
          ),
        ),
      );
    }
  }

  double calculateProgress(double maxWidth) {
    return maxWidth * ((currentPage + 1) / totalPages);
  }

  double calculateIconPosition(double maxWidth, double iconWidth) {
    double progress = calculateProgress(maxWidth);
    return progress.clamp(0, maxWidth - iconWidth);
  }

  @override
  Widget build(BuildContext context) {
    final currentFruit = fruitPages[currentPage];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGC.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  // Header
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // Progress Bar + Icon
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),

                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth = constraints.maxWidth - 20;
                        double iconWidth = 25;

                        return Stack(
                          children: [
                            Positioned(
                              top: 9,
                              left: 10,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: calculateProgress(maxWidth),
                                height: 11,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    228,
                                    197,
                                    73,
                                  ),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              left:
                                  10 +
                                  calculateIconPosition(maxWidth, iconWidth),
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
                  // ✅ Floating Fruit Selector
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 20),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.3, // responsive
                          height: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.26,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/head.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 19),
                        CustomPaint(
                          size: Size(screenWidth * 0.1, screenWidth * 0.05),
                          painter: TrianglePainter(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ภาพผลไม้
                  Container(
                    width: screenWidth * 0.7,
                    height: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        showColor
                            ? currentFruit["imageColor"]
                            : currentFruit["imageBW"],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ปุ่มเลือกผลไม้
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: (currentFruit["options"] as List).map((opt) {
                      return GestureDetector(
                        onTap: () {
                          setState(() => showColor = true);
                          _handleAnswer(opt["isCorrect"] as bool);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(opt["image"] as String),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
