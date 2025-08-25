import 'dart:async' as dart_async;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: GameWidgetWithUI(game: SideScrollGame())),
    ),
  );
}

class SideScrollGame extends FlameGame with HasCollisionDetection {
  SpriteComponent? character;
  SpriteComponent? background;
  CameraComponent? cameraComponent;
  late World world;

  double characterSpeed = 250;
  double totalDistance = 1600; // ระยะทางที่ยาวกว่าหน้าจอ
  double distanceTraveled = 0;

  final progressNotifier = ValueNotifier<double>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    world = World();
    add(world);

    // ✅ กล้องแบบ fixed resolution
    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 900, // ความกว้าง virtual สำหรับ Galaxy Tab A9+
      height: 1600,
    );
    add(cameraComponent!);

    // ✅ พื้นหลังยาว
    background = SpriteComponent()
      ..sprite = await loadSprite('/GameBG/bg1.png')
      ..size = Vector2(totalDistance * 5, 2500)
      ..position = Vector2.zero()
      ..priority = -1;
    world.add(background!);

    // ✅ ตัวละคร
    character = SpriteComponent()
      ..sprite = await loadSprite('character.png')
      ..size = Vector2(400, 600)
      ..position = Vector2(400, 1400);
    world.add(character!);

    // ✅ กล้องตามตัวละคร
    cameraComponent!.follow(character!);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // ✅ ตรวจสอบก่อนใช้
    if (cameraComponent != null && size.x > 0 && size.y > 0) {
      cameraComponent!.viewfinder.visibleGameSize = size;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // ✅ ตัวละครเคลื่อนที่และอัปเดต progress
    distanceTraveled = distanceTraveled.clamp(0, totalDistance);
    character?.x = distanceTraveled;
    progressNotifier.value = distanceTraveled / totalDistance;
  }

  // ✅ ฟังก์ชันเคลื่อนที่
  void move(double dir, double dt) {
    distanceTraveled += dir * characterSpeed * dt;
  }
}

// -------------------------------------------------------------

class GameWidgetWithUI extends StatefulWidget {
  final SideScrollGame game;
  const GameWidgetWithUI({super.key, required this.game});

  @override
  State<GameWidgetWithUI> createState() => _GameWidgetWithUIState();
}

class _GameWidgetWithUIState extends State<GameWidgetWithUI> {
  dart_async.Timer? holdTimer;

  @override
  void initState() {
    super.initState();
    widget.game.progressNotifier.addListener(_onProgressUpdate);
  }

  void _onProgressUpdate() => setState(() {});

  @override
  void dispose() {
    widget.game.progressNotifier.removeListener(_onProgressUpdate);
    holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.game.progressNotifier.value;

    return Stack(
      children: [
        // ✅ GameWidget ต้องเป็น child แรก
        GameWidget(game: widget.game),

        // ✅ Progress Bar ด้านบน
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < 3; i++)
                          const Icon(Icons.star_border, color: Colors.blue),
                        const Icon(Icons.flag, color: Colors.blue),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      child: Image.asset(
                        'assets/images/head.png', // ไอคอนใน progress bar
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ✅ ปุ่มควบคุมด้านล่าง
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(Icons.arrow_back, -1),
                _buildControlButton(Icons.arrow_forward, 1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, double direction) {
    return Listener(
      onPointerDown: (_) {
        widget.game.move(direction, 0.1);
        holdTimer = dart_async.Timer.periodic(
          const Duration(milliseconds: 50),
          (_) => widget.game.move(direction, 0.05),
        );
      },
      onPointerUp: (_) => holdTimer?.cancel(),
      onPointerCancel: (_) => holdTimer?.cancel(),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        child: Icon(icon, size: 60),
      ),
    );
  }
}
