// lib/matching_game.dart
// Matching (Image ↔ Sound) game with kid-friendly UI, responsive grid, audio preloading,
// and polished overlays. Drop this file into your Flutter project and wire it up from a page.

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

// =============================
// 1) Game params
// =============================
class MatchingParams {
  final int totalRounds; // จำนวนรอบทั้งหมด
  final int itemsPerRound; // จำนวนภาพต่อรอบ
  final double roundTimeSeconds; // เวลาต่อรอบ (วินาที)
  const MatchingParams({
    required this.totalRounds,
    required this.itemsPerRound,
    required this.roundTimeSeconds,
  });
}

// =============================
// 2) Main Flame game
// =============================
class MatchingGame extends FlameGame with HasCollisionDetection {
  MatchingGame({required this.params});
  final MatchingParams params;

  @override
  Color backgroundColor() => const Color(0xFFFAF7FF); // พื้นหลังโทนอ่อน

  // ไลบรารีภาพ + เสียง (key → (imagePath, soundPath))
  final Map<String, (String imagePath, String soundPath)> _library = {
    'cat': ('images/Gameassets/3.1/cat.jpeg', 'sounds/cat.mp3'),
    'dog': ('images/Gameassets/3.1/dog.jpeg', 'sounds/dog.mp3'),
    'cow': ('images/Gameassets/3.1/cow.jpeg', 'sounds/cow.mp3'),
    'car': ('images/Gameassets/3.1/car.jpeg', 'sounds/car.mp3'),
  };

  // State
  final _rand = Random();
  late final TimerComponent _timer;

  bool _isPlaying = false;
  bool _muted = false;

  int _round = 0; // เริ่มจาก 0 แล้วค่อย +1 ในแต่ละรอบ
  int _score = 0;
  double _timeLeft = 0;
  int _successRounds = 0; // นับรอบที่ผ่านสำเร็จ (เคลียร์รายการทันเวลาก่อนหมดเวลา)

  List<String> _currentKeys = [];
  String? _currentTargetKey;

  // Layout tuning
  static const double _padding = 16.0;
  static const double _topGameMargin = 120.0; // เผื่อพื้นที่ HUD ด้านบน

  // =============================
  // Lifecycle
  // =============================
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Preload images & audios for smoother UX
    await images.loadAll(_library.values.map((e) => e.$1).toSet().toList());
    await FlameAudio.audioCache.loadAll(
      _library.values.map((e) => e.$2).toSet().toList(),
    );

    // Timer: นับถอยหลังเป็นวินาที
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

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // ปรับเลย์เอาต์ใหม่เมื่อขนาดจอเปลี่ยน
    if (_isPlaying) {
      _respawnImagesOnly();
    }
  }

  // =============================
  // Public API (called from overlays)
  // =============================
  void startGame() {
    _score = 0;
    _round = 0;
    _successRounds = 0;
    _isPlaying = true;
    overlays.remove('Start');
    overlays.add('HUD');
    _startNextRound();
  }

  void restartGame() {
    overlays.remove('End');
    startGame();
  }

  void toggleMute() {
    _muted = !_muted;
  }

  void replaySound() {
    if (_currentTargetKey != null && !_muted) {
      FlameAudio.play(_library[_currentTargetKey]!.$2);
    }
  }

  // =============================
  // Round flow
  // =============================
  void _startNextRound() {
    _round++;
    _timeLeft = params.roundTimeSeconds;

    if (_round > params.totalRounds) {
      _finishGame();
      return;
    }

    final allKeys = _library.keys.toList()..shuffle(_rand);
    final take = params.itemsPerRound.clamp(1, allKeys.length);
    _currentKeys = allKeys.take(take).toList();

    _spawnImages();
    _pickAndPlayNextTarget();
  }

  void _pickAndPlayNextTarget() {
    if (_currentKeys.isEmpty) {
      _endRound(success: true);
      return;
    }
    _currentTargetKey = (_currentKeys..shuffle(_rand)).first;
    if (!_muted) {
      FlameAudio.play(_library[_currentTargetKey]!.$2);
    }
  }

  void _onCardTapped(String keyId) {
    if (!_isPlaying || _currentTargetKey == null) return;

    if (keyId == _currentTargetKey) {
      _score += 1;
      _currentKeys.remove(keyId);
      _pickAndPlayNextTarget();
    } else {
      _timeLeft = max(0, _timeLeft - 2); // ผิด หักเวลาเล็กน้อย
    }
  }

  void _endRound({required bool success}) {
    if (success && _timeLeft > 0) {
      _successRounds++;
    }

    if (_round < params.totalRounds) {
      _startNextRound();
    } else {
      _finishGame();
    }
  }

  void _finishGame() {
    _isPlaying = false;
    overlays.remove('HUD');
    overlays.add('End');
  }

  // =============================
  // Layout & spawning
  // =============================
  void _spawnImages() {
    // ล้างของเดิมก่อน
    children.whereType<ImageCard>().toList().forEach(remove);

    _respawnImagesOnly();
  }

  void _respawnImagesOnly() {
    // สร้างใหม่จาก _currentKeys ตามขนาดจอปัจจุบัน
    // คำนวณจำนวนคอลัมน์ตามความกว้างจอ เพื่อให้ responsive
    final n = _currentKeys.length;
    if (n == 0) return;

    final minCellWidth = 160.0; // อย่าให้ช่องเล็กเกินไป
    final maxColsByWidth = (size.x / (minCellWidth + _padding)).floor().clamp(2, 6);
    final cols = max(2, min(maxColsByWidth, n));
    final rows = (n / cols).ceil();

    final areaTop = _padding + _topGameMargin;
    final areaHeight = size.y - areaTop - _padding;

    final cellW = (size.x - _padding * (cols + 1)) / cols;
    final cellH = (areaHeight - _padding * (rows + 1)) / rows;
    final cellSize = Vector2(cellW, cellH);

    for (int i = 0; i < n; i++) {
      final key = _currentKeys[i];
      final r = i ~/ cols;
      final c = i % cols;
      final pos = Vector2(
        _padding + c * (cellW + _padding),
        areaTop + r * (cellH + _padding),
      );

      final card = ImageCard(
        keyId: key,
        spritePath: _library[key]!.$1,
        onTapped: _onCardTapped,
      )
        ..size = cellSize
        ..position = pos;
      add(card);
    }
  }

  // Getters for overlays
  int get score => _score;
  int get round => _round.clamp(0, params.totalRounds).toInt();
  double get timeLeft => _timeLeft;
  int get totalRounds => params.totalRounds;
  bool get isPlaying => _isPlaying;
  int get successRounds => _successRounds;
  bool get muted => _muted;

  int calculateStars() {
    final percent = (successRounds / params.totalRounds) * 100;
    if (percent <= 40) return 1;
    if (percent <= 80) return 2;
    return 3;
  }
}

// =============================
// 3) Image card (tappable)
// =============================
class ImageCard extends SpriteComponent with TapCallbacks, HasGameRef<MatchingGame> {
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

    // เข้าสู่จอด้วยแอนิเมชันเล็กน้อย
    scale = Vector2.all(0.92);
    add(ScaleEffect.to(
      Vector2.all(1.0),
      EffectController(duration: 0.25, curve: Curves.easeOutBack),
    ));

    // ใส่เงา/ขอบด้วย Paint (วาดผ่าน decorator)
    paint = Paint()
      ..filterQuality = FilterQuality.high;
  }

  @override
  void render(Canvas canvas) {
    // วาด card background (มุมโค้ง + เงาอ่อน)
    final rrect = RRect.fromRectAndRadius(
      (toRect()..inflate(0)),
      const Radius.circular(18),
    );
    final bgPaint = Paint()..color = const Color(0xFFFFFFFF);
    final shadow = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.save();
    // เงา
    canvas.drawRRect(rrect.shift(const Offset(0, 3)), shadow);
    // พื้น
    canvas.drawRRect(rrect, bgPaint);
    canvas.clipRRect(rrect);
    // วาด sprite
    super.render(canvas);
    canvas.restore();
  }

  @override
  void onTapUp(TapUpEvent event) {
    // ฟีดแบ็กการแตะ
    add(SequenceEffect([
      ScaleEffect.to(Vector2.all(0.95), EffectController(duration: 0.06)),
      ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.08)),
    ]));
    onTapped(keyId);
  }
}

// =============================
// 4) Overlays (Flutter widgets)
// =============================
class HUDOverlay extends StatelessWidget {
  const HUDOverlay(this.game, {super.key});
  final MatchingGame game;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.045; // responsive

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.width * 0.02,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8BC6EC), Color(0xFF9599E2)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Row(
            children: [
              _HUDChip(
                icon: Icons.timelapse,
                label: 'เวลา',
                value: game.timeLeft.toStringAsFixed(0),
                fontSize: fontSize,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TimeBar(
                  progress: (game.timeLeft / game.params.roundTimeSeconds)
                      .clamp(0, 1),
                ),
              ),
              const SizedBox(width: 12),
              _HUDChip(
                icon: Icons.sports_score,
                label: 'คะแนน',
                value: '${game.score}',
                fontSize: fontSize,
              ),
              const SizedBox(width: 12),
              _HUDChip(
                icon: Icons.flag,
                label: 'รอบ',
                value: '${game.round}/${game.totalRounds}',
                fontSize: fontSize,
              ),
              const SizedBox(width: 12),
              _RoundButton(
                icon: Icons.volume_up,
                tooltip: 'ฟังอีกครั้ง',
                onTap: game.replaySound,
              ),
              const SizedBox(width: 10),
              _RoundButton(
                icon: game.muted ? Icons.volume_off : Icons.volume_up_outlined,
                tooltip: game.muted ? 'เปิดเสียง' : 'ปิดเสียง',
                onTap: game.toggleMute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HUDChip extends StatelessWidget {
  const _HUDChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.fontSize,
  });
  final IconData icon;
  final String label;
  final String value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.6,
        vertical: fontSize * 0.4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: fontSize, color: const Color(0xFF4E54C8)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize * 0.7,
                  color: Colors.black54,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4E54C8),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TimeBar extends StatelessWidget {
  const _TimeBar({required this.progress});
  final double progress; // 0..1
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: LinearProgressIndicator(
        minHeight: 16,
        value: progress,
        backgroundColor: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, this.tooltip, this.onTap});
  final IconData icon;
  final String? tooltip;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final btn = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF4E54C8)),
      ),
    );
    return tooltip == null ? btn : Tooltip(message: tooltip!, child: btn);
  }
}

class StartOverlay extends StatelessWidget {
  const StartOverlay({super.key, required this.onStart});
  final VoidCallback onStart;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE29F), Color(0xFFFF719A), Color(0xFF9CFFAC)],
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'เกมจับคู่ภาพกับเสียง',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'แตะรูปที่ตรงกับเสียงที่ได้ยิน \nแตะปุ่ม \"ฟังอีกครั้ง\" ได้หากต้องการ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E54C8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: onStart,
                icon: const Icon(Icons.play_arrow),
                label: const Text('เริ่มเกม', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndOverlay extends StatelessWidget {
  const EndOverlay({super.key, required this.game, required this.onRestart});
  final MatchingGame game;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final stars = game.calculateStars();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB3FFAB), Color(0xFF12FFF7)],
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('จบเกม', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text('คะแนนรวม: ${game.score}', style: const TextStyle(fontSize: 18, color: Colors.black87)),
              Text('รอบที่ผ่าน: ${game.successRounds}/${game.totalRounds}', style: const TextStyle(fontSize: 18, color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => Icon(
                  i < stars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                )),
              ),
              const SizedBox(height: 22),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E54C8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                onPressed: onRestart,
                icon: const Icon(Icons.restart_alt),
                label: const Text('เล่นอีกครั้ง', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================
// 5) Example page (GameWidget wiring)
// =============================
class MatchingGamePage extends StatelessWidget {
  const MatchingGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = MatchingGame(
      params: const MatchingParams(
        totalRounds: 6,
        itemsPerRound: 6,
        roundTimeSeconds: 20,
      ),
    );

    return Scaffold(
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'Start': (context, _) => StartOverlay(onStart: game.startGame),
          'HUD': (context, _) => HUDOverlay(game),
          'End': (context, _) => EndOverlay(game: game, onRestart: game.restartGame),
        },
        initialActiveOverlays: const ['Start'],
      ),
    );
  }
}
