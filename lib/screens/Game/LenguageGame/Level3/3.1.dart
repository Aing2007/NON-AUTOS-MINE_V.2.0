import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

// main() คือจุดเริ่มต้นของแอป
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // โหลดไฟล์เสียง
  await FlameAudio.audioCache.loadAll([
    'sounds/cat.mp3',
    'sounds/dog.mp3',
    'sounds/cow.mp3',
    'sounds/car.mp3',
  ]);

  // โหลดไฟล์ภาพ
  await Flame.images.loadAll([
    'images/cat.png',
    'images/dog.png',
    'images/cow.png',
    'images/car.png',
  ]);

  // กำหนดพารามิเตอร์เกม
  final params = MatchingParams(
    totalRounds: 10, // จำนวนรอบ
    itemsPerRound: 3, // จำนวนภาพต่อรอบ
    roundTimeSeconds: 10, // เวลาต่อรอบ
  );

  // สร้างเกมและรัน
  final game = MatchingGame(params: params);
  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'HUD': (context, game) => HUDOverlay(game as MatchingGame),
        'Start': (context, game) => StartOverlay(
              onStart: () => (game as MatchingGame).startGame(),
            ),
        'End': (context, game) => EndOverlay(
              game: game as MatchingGame,
              onRestart: () => (game as MatchingGame).restartGame(),
            ),
      },
      initialActiveOverlays: const ['Start'],
    ),
  );
}

// กำหนดพารามิเตอร์เกม
class MatchingParams {
  final int totalRounds;
  final int itemsPerRound;
  final double roundTimeSeconds;
  const MatchingParams({
    required this.totalRounds,
    required this.itemsPerRound,
    required this.roundTimeSeconds,
  });
}

// คลาสหลักของเกม
class MatchingGame extends FlameGame with HasTappables, HasCollisionDetection {
  MatchingGame({required this.params});
  final MatchingParams params;

  // ไลบรารีภาพและเสียง
  final Map<String, (String imagePath, String soundPath)> _library = {
    'cat': ('images/cat.png', 'sounds/cat.mp3'),
    'dog': ('images/dog.png', 'sounds/dog.mp3'),
    'cow': ('images/cow.png', 'sounds/cow.mp3'),
    'car': ('images/car.png', 'sounds/car.mp3'),
  };

  int _round = 0;
  int _score = 0;
  double _timeLeft = 0;
  bool _isPlaying = false;

  List<String> _currentKeys = [];
  String? _currentTargetKey;

  final _rand = Random();

  // TimerComponent สำหรับจับเวลา
  late final TimerComponent _timer;

  // สำหรับคำนวณดาว
  int _successRounds = 0; // รอบที่ผ่านสำเร็จภายในเวลา

  static const int _cols = 4;
  static const double _padding = 16;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // สร้าง TimerComponent ด้วย onTick
    _timer = TimerComponent(
      period: 1,
      repeat: true,
      onTick: () {
        if (!_isPlaying) return;
        _timeLeft = max(0, _timeLeft - 1);
        if (_timeLeft <= 0) {
          _endRound(success: false);
        }
      },
    );
    add(_timer);
  }

  // เริ่มเกมใหม่
  void startGame() {
    _score = 0;
    _round = 0;
    _successRounds = 0;
    _isPlaying = true;
    overlays.remove('Start');
    overlays.add('HUD');
    _startNextRound();
  }

  // รีสตาร์ทเกม
  void restartGame() {
    overlays.remove('End');
    startGame();
  }

  // เริ่มรอบถัดไป
  void _startNextRound() {
    _round++;
    _timeLeft = params.roundTimeSeconds;

    if (_round > params.totalRounds) {
      _finishGame();
      return;
    }

    final allKeys = _library.keys.toList();
    allKeys.shuffle(_rand);
    _currentKeys = allKeys.take(params.itemsPerRound.clamp(1, allKeys.length)).toList();
    _spawnImages();
    _pickAndPlayNextTarget();
  }

  // สร้าง ImageCard สำหรับแต่ละภาพ
  void _spawnImages() async {
    children.whereType<ImageCard>().toList().forEach(remove);
    final sizePerCell = Vector2(
      (size.x - (_padding * (_cols + 1))) / _cols,
      (size.y - (_padding * 3)) / 2,
    );

    for (int i = 0; i < _currentKeys.length; i++) {
      final key = _currentKeys[i];
      final row = i ~/ _cols;
      final col = i % _cols;
      final pos = Vector2(
        _padding + col * (sizePerCell.x + _padding),
        _padding + row * (sizePerCell.y + _padding),
      );
      final card = ImageCard(
        keyId: key,
        spritePath: _library[key]!.$1,
        onTapped: _onCardTapped,
      )
        ..size = sizePerCell
        ..position = pos;
      add(card);
    }
  }

  // เลือกเป้าหมายและเล่นเสียง
  void _pickAndPlayNextTarget() {
    if (_currentKeys.isEmpty) {
      _endRound(success: true);
      return;
    }
    _currentTargetKey = (_currentKeys..shuffle(_rand)).first;
    final sound = _library[_currentTargetKey]!.$2;
    FlameAudio.play(sound);
  }

  // เมื่อแตะภาพ
  void _onCardTapped(String keyId) {
    if (!_isPlaying || _currentTargetKey == null) return;
    if (keyId == _currentTargetKey) {
      _score += 1;
      _currentKeys.remove(keyId);
      _pickAndPlayNextTarget();
    } else {
      _timeLeft = max(0, _timeLeft - 2);
    }
  }

  // ฟังเสียงซ้ำ
  void replaySound() {
    if (_currentTargetKey != null) {
      final sound = _library[_currentTargetKey]!.$2;
      FlameAudio.play(sound);
    }
  }

  // จบรอบ
  void _endRound({required bool success}) {
    if (success && _timeLeft > 0) {
      _successRounds++; // นับรอบที่สำเร็จภายในเวลา
    }
    if (_round < params.totalRounds) {
      _startNextRound();
    } else {
      _finishGame();
    }
  }

  // จบเกม
  void _finishGame() {
    _isPlaying = false;
    overlays.remove('HUD');
    overlays.add('End');
  }

  // Getter สำหรับ HUD
  int get score => _score;
  int get round => _round.clamp(0, params.totalRounds).toInt();
  double get timeLeft => _timeLeft;
  int get totalRounds => params.totalRounds;
  bool get isPlaying => _isPlaying;
  int get successRounds => _successRounds; // S

  // คำนวณดาว
  int calculateStars() {
    final percent = (successRounds / params.totalRounds) * 100;
    if (percent <= 40) return 1;
    if (percent <= 80) return 2;
    return 3;
  }
}

// ImageCard คือภาพที่แตะได้
class ImageCard extends SpriteComponent with TapCallbacks {
  ImageCard({
    required this.keyId,
    required this.spritePath,
    required this.onTapped,
  });

  final String keyId;
  final String spritePath;
  final void Function(String keyId) onTapped;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(spritePath);
    anchor = Anchor.topLeft;
  }

  @override
  void onTapUp(TapUpEvent event) {
    onTapped(keyId);
  }
}

// HUDOverlay แสดง HUD ด้านบน
class HUDOverlay extends StatelessWidget {
  const HUDOverlay(this.game, {super.key});
  final MatchingGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HUDChip(icon: Icons.timelapse, label: 'เวลา', value: game.timeLeft.toStringAsFixed(0)),
              _HUDChip(icon: Icons.sports_score, label: 'คะแนน', value: '${game.score}'),
              _HUDChip(icon: Icons.flag, label: 'รอบ', value: '${game.round}/${game.totalRounds}'),
              ElevatedButton.icon(
                onPressed: game.replaySound,
                icon: const Icon(Icons.volume_up),
                label: const Text('ฟังอีกครั้ง'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _HUDChip คือกล่องแสดงข้อมูลใน HUD
class _HUDChip extends StatelessWidget {
  const _HUDChip({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

// StartOverlay คือหน้าจอเริ่มเกม
class StartOverlay extends StatelessWidget {
  const StartOverlay({super.key, required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('เกมจับคู่ภาพกับเสียง', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('แตะรูปที่ตรงกับเสียงที่ได้ยิน', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow),
              label: const Text('เริ่มเกม'),
            ),
          ],
        ),
      ),
    );
  }
}

// EndOverlay คือหน้าจอจบเกม
class EndOverlay extends StatelessWidget {
  const EndOverlay({super.key, required this.game, required this.onRestart});
  final MatchingGame game;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final stars = game.calculateStars();
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('จบเกม', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('คะแนนรวม: ${game.score}', style: const TextStyle(color: Colors.white70, fontSize: 18)),
            Text('รอบที่ผ่าน: ${game.successRounds}/${game.totalRounds}', style: const TextStyle(color: Colors.white70, fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => Icon(
                i < stars ? Icons.star : Icons.star_border,
                color: Colors.yellow,
                size: 36,
              )),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.restart_alt),
              label: const Text('เล่นอีกครั้ง'),
            ),
          ],
        ),
      ),
    );
  }
}