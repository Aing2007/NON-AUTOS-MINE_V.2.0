import 'package:flutter/material.dart';
import '/widgets/headerGame.dart';
import '../../../../AIfunction/TTS.dart';
import '../summaryGameS.dart';

/// ------------------------------
/// OOP Models
/// ------------------------------
class MatchOption {
  final String id; // unique id เช่น "l1", "r3"
  final String iconPath; // พาธรูป
  final Color dotColor; // สีจุด (และใช้เป็นสีเส้นสำหรับคู่ของฝั่งซ้าย)

  const MatchOption({
    required this.id,
    required this.iconPath,
    required this.dotColor,
  });
}

class MatchQuestion {
  final String question;
  final List<MatchOption> leftOptions; // 4 items
  final List<MatchOption> rightOptions; // 4 items
  final Map<String, String> answers; // mapping: leftId -> rightId

  /// หมายเหตุ:
  /// - สีเส้นจะอ้างจากสีของ leftOptions ตาม index (กำหนดเองต่อข้อได้)
  const MatchQuestion({
    required this.question,
    required this.leftOptions,
    required this.rightOptions,
    required this.answers,
  });
}

/// ใช้เก็บเส้นที่ยืนยันแล้ว
class ConnectionLine {
  final String leftId;
  final String rightId;
  final Offset start;
  final Offset end;
  final Color color;

  const ConnectionLine({
    required this.leftId,
    required this.rightId,
    required this.start,
    required this.end,
    required this.color,
  });
}

/// ------------------------------
/// หน้าหลัก: เกมโยงเส้น
/// ------------------------------
class SelectMatchConnect extends StatefulWidget {
  const SelectMatchConnect({Key? key}) : super(key: key);

  @override
  State<SelectMatchConnect> createState() => _SelectMatchConnectState();
}

class _SelectMatchConnectState extends State<SelectMatchConnect> {
  // คะแนนรวม (สูงสุด 40)
  int totalScore = 0;

  // index ข้อปัจจุบัน
  int currentPage = 0;

  // โจทย์ทั้งหมด 10 ข้อ (ปรับพาธรูป/สีได้ตามธีมของคุณ)
  late final List<MatchQuestion> questions = [
    MatchQuestion(
      question:
          "1.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง", //==============================================โจทย์
      leftOptions: const [
        MatchOption(
          id: "l1", //====================================================ฝั่งซ้าย
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFA47FD6),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF8BC7AD),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFED371),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1", //====================================================ฝั่งขวา
          iconPath: "assets/game_assets/prototype/fruit/apple.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/banana.png",
          dotColor: Color(0xFFFED371),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF8BC7AD),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFFA47FD6),
        ),
      ],
      answers: const {
        "l1": "r4",
        "l2": "r3",
        "l3": "r1",
        "l4": "r2",
      }, //==========================คู่คำตอบ
    ),

    MatchQuestion(
      question: "2.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFD54F),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF8BC7AD),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/apple.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/banana.png",
          dotColor: Color(0xFFFFD54F),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF8BC7AD),
        ),
      ],
      answers: const {"l1": "r3", "l2": "r1", "l3": "r4", "l4": "r2"},
    ),

    MatchQuestion(
      question: "3.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFE57373),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFA47FD6),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/strawberry.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFF9575CD),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/lemon.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
      ],
      answers: const {"l1": "r1", "l2": "r3", "l3": "r4", "l4": "r2"},
    ),

    MatchQuestion(
      question: "4.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Pink.png",
          dotColor: Color(0xFFF48FB1),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/peach.png",
          dotColor: Color(0xFFF48FB1),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/lemon.png",
          dotColor: Color(0xFFFFB74D),
        ),
      ],
      answers: const {"l1": "r2", "l2": "r3", "l3": "r1", "l4": "r4"},
    ),

    MatchQuestion(
      question: "5.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFBA68C8),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/strawberry.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/banana.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFFBA68C8),
        ),
      ],
      answers: const {"l1": "r4", "l2": "r3", "l3": "r1", "l4": "r2"},
    ),

    MatchQuestion(
      question: "6.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Pink.png",
          dotColor: Color(0xFFF48FB1),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFB39DDB),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFFBA68C8),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/peach.png",
          dotColor: Color(0xFFF48FB1),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/apple.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
      ],
      answers: const {"l1": "r2", "l2": "r1", "l3": "r4", "l4": "r3"},
    ),

    MatchQuestion(
      question: "7.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFBA68C8),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF4DB6AC),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/lemon.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFFBA68C8),
        ),
      ],
      answers: const {"l1": "r2", "l2": "r4", "l3": "r3", "l4": "r1"},
    ),

    MatchQuestion(
      question: "8.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Pink.png",
          dotColor: Color(0xFFF48FB1),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/apple.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/pineapple.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/peach.png",
          dotColor: Color(0xFFF48FB1),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF4DB6AC),
        ),
      ],
      answers: const {"l1": "r4", "l2": "r1", "l3": "r2", "l4": "r3"},
    ),

    MatchQuestion(
      question: "9.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Purple.png",
          dotColor: Color(0xFFBA68C8),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/strawberry.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/grab.png",
          dotColor: Color(0xFFBA68C8),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/pineapple.png",
          dotColor: Color(0xFFFFB74D),
        ),
      ],
      answers: const {"l1": "r3", "l2": "r1", "l3": "r4", "l4": "r2"},
    ),

    MatchQuestion(
      question: "10.จับคู่สีของคนที่เหมือนกับสีของผลไม้ให้ถูกต้อง",
      leftOptions: const [
        MatchOption(
          id: "l1",
          iconPath: "assets/game_assets/prototype/personcolor/Yellow.png",
          dotColor: Color(0xFFFFB74D),
        ),
        MatchOption(
          id: "l2",
          iconPath: "assets/game_assets/prototype/personcolor/Red.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "l3",
          iconPath: "assets/game_assets/prototype/personcolor/Brawn.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
        MatchOption(
          id: "l4",
          iconPath: "assets/game_assets/prototype/personcolor/Green.png",
          dotColor: Color(0xFF4DB6AC),
        ),
      ],
      rightOptions: const [
        MatchOption(
          id: "r1",
          iconPath: "assets/game_assets/prototype/fruit/pineapple.png",
          dotColor: Color(0xFFFFD54F),
        ),
        MatchOption(
          id: "r2",
          iconPath: "assets/game_assets/prototype/fruit/watermelon.png",
          dotColor: Color(0xFFF65A3B),
        ),
        MatchOption(
          id: "r3",
          iconPath: "assets/game_assets/prototype/fruit/kiwi.png",
          dotColor: Color(0xFF4DB6AC),
        ),
        MatchOption(
          id: "r4",
          iconPath: "assets/game_assets/prototype/fruit/coconut.png",
          dotColor: Color.fromARGB(255, 113, 67, 50),
        ),
      ],
      answers: const {"l1": "r1", "l2": "r2", "l3": "r4", "l4": "r3"},
    ),
  ];

  int get totalPages => questions.length;

  // ------------------------------
  // สำหรับลากเส้น
  // ------------------------------
  final GlobalKey _stackKey = GlobalKey();

  // ใช้ map เก็บ GlobalKey ของจุด (ซ้าย/ขวา)
  final Map<String, GlobalKey> _dotKeys = {};

  // ตำแหน่ง center ของจุด (ในพิกัดของ Stack)
  final Map<String, Offset> _dotPositions = {};

  // เส้นที่ confirm แล้ว
  final List<ConnectionLine> _confirmedLines = [];

  // เชื่อมแล้ว (leftId -> rightId)
  final Map<String, String> _connections = {};

  // สิทธิ์ของ right ที่ถูกใช้แล้ว (กันซ้ำ)
  final Set<String> _usedRight = {};

  // กำลังลากจาก left ไหนอยู่ + ตำแหน่งนิ้วปัจจุบัน
  String? _draggingLeftId;
  Offset? _currentDragPos;

  @override
  void initState() {
    super.initState();
    // พูดคำถามแรก
    _speakQuestion();
    // เก็บคีย์ของทุกจุด
    _prepareDotKeys();
    // รอ build เสร็จแล้วค่อยคำนวณตำแหน่ง
    WidgetsBinding.instance.addPostFrameCallback((_) => _computeDotPositions());
  }

  void _speakQuestion() {
    TtsService.speak(questions[currentPage].question, rate: 0.5, pitch: 1.0);
  }

  void _prepareDotKeys() {
    for (final q in questions) {
      for (final l in q.leftOptions) {
        _dotKeys[l.id] = GlobalKey();
      }
      for (final r in q.rightOptions) {
        _dotKeys[r.id] = GlobalKey();
      }
    }
  }

  void _computeDotPositions() {
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null) return;

    Offset toStackLocal(Offset global) => stackBox.globalToLocal(global);

    void save(String id) {
      final key = _dotKeys[id];
      if (key?.currentContext == null) return;
      final box = key!.currentContext!.findRenderObject() as RenderBox;
      final pos = box.localToGlobal(Offset.zero);
      final size = box.size;
      _dotPositions[id] = toStackLocal(
        pos + Offset(size.width / 2, size.height / 2),
      );
    }

    final q = questions[currentPage];
    for (final l in q.leftOptions) {
      save(l.id);
    }
    for (final r in q.rightOptions) {
      save(r.id);
    }
    setState(() {});
  }

  // คำนวณความกว้าง Progress (เหมือนต้นแบบ)
  double _calculateProgress(double maxWidth) {
    return maxWidth * ((currentPage + 1) / totalPages);
  }

  double _calculateIconPosition(double maxWidth, double iconWidth) {
    final progress = _calculateProgress(maxWidth);
    return (progress - iconWidth / 2).clamp(0, maxWidth - iconWidth);
  }

  // เริ่มลากจาก leftId
  void _startDrag(String leftId, DragStartDetails d) {
    if (_connections.containsKey(leftId)) return; // เชื่อมแล้วห้ามลากซ้ำ
    setState(() {
      _draggingLeftId = leftId;
      _currentDragPos = d.globalPosition;
    });
  }

  // อัปเดตตำแหน่งระหว่างลาก
  void _updateDrag(DragUpdateDetails d) {
    if (_draggingLeftId == null) return;
    setState(() {
      _currentDragPos = d.globalPosition;
    });
  }

  // ปล่อยนิ้ว: หาปลายทาง right ที่อยู่ในระยะ
  void _endDrag(DragEndDetails d) {
    if (_draggingLeftId == null) return;

    final leftId = _draggingLeftId!;
    _draggingLeftId = null;

    // แปลงตำแหน่งปล่อยจาก global -> local(Stack)
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null) return;
    final endLocal = stackBox.globalToLocal(_currentDragPos ?? Offset.zero);

    // หา right ที่ใกล้ที่สุดและอยู่ใน threshold
    const threshold = 36.0;
    String? targetRightId;
    double bestDist = double.infinity;

    for (final r in questions[currentPage].rightOptions) {
      if (_usedRight.contains(r.id)) continue; // ถูกใช้แล้ว
      final rp = _dotPositions[r.id];
      if (rp == null) continue;
      final dist = (rp - endLocal).distance;
      if (dist < bestDist && dist <= threshold) {
        bestDist = dist;
        targetRightId = r.id;
      }
    }

    if (targetRightId == null) {
      // ไม่โดนจุดไหน -> ยกเลิก
      setState(() {
        _currentDragPos = null;
      });
      return;
    }

    // สร้าง connection ถ้ายังไม่เคยเชื่อม
    if (!_connections.containsKey(leftId) &&
        !_usedRight.contains(targetRightId)) {
      final lp = _dotPositions[leftId];
      final rp = _dotPositions[targetRightId];
      if (lp != null && rp != null) {
        // หา index ของ left เพื่อใช้สีประจำคู่
        final leftIndex = questions[currentPage].leftOptions.indexWhere(
          (e) => e.id == leftId,
        );
        final lineColor =
            questions[currentPage].leftOptions[leftIndex].dotColor;

        setState(() {
          _connections[leftId] = targetRightId!;
          _usedRight.add(targetRightId!);
          _confirmedLines.add(
            ConnectionLine(
              leftId: leftId,
              rightId: targetRightId!,
              start: lp,
              end: rp,
              color: lineColor,
            ),
          );
          _currentDragPos = null;
        });

        // ให้คะแนนทันทีหากเชื่อมถูก
        final correctMap = questions[currentPage].answers;
        if (correctMap[leftId] == targetRightId) {
          totalScore += 1; // คู่ละ 1 คะแนน ⇒ ข้อละ 4 คะแนน
          print("score : ${totalScore}");
        }

        // ถ้าเชื่อมครบ 4 คู่แล้ว -> ไปข้อถัดไป
        if (_connections.length == 4) {
          Future.delayed(const Duration(milliseconds: 350), _goNextOrSummary);
          print("ไปหน้าถัดไป");
        }
      }
    } else {
      setState(() {
        _currentDragPos = null;
        print("ตอบผิด");
      });
    }
  }

  void _goNextOrSummary() {
    if (currentPage < totalPages - 1) {
      setState(() {
        currentPage += 1;
        _confirmedLines.clear();
        _connections.clear();
        _usedRight.clear();
      });
      _speakQuestion();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _computeDotPositions(),
      );
    } else {
      final int score = totalScore ~/ 4; //หารเอาจำนวนเต็ม

      // พูดคะแนน
      TtsService.speak(
        "คุณทำคะแนนได้ $score คะแนน จากทั้งหมด 10 คะแนน",
        rate: 0.5,
        pitch: 1.0,
      );

      // ไปหน้าสรุป
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => buildSummaryScreen_S(
            context: context,
            totalScore: score,
            currentLevel: 1,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentPage];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/GameBG/StartBGS.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  // Header (คงเดิม)
                  GameHeader(
                    money: "12,000,000.00",
                    profileImage: "assets/images/head.png",
                  ),
                  const SizedBox(height: 20),

                  // Progress Bar (คงเดิม + ไอคอนเคลื่อน)
                  // ------------------------------
                  // Progress bar + moving icon
                  // ------------------------------
                  Container(
                    width: double.infinity,
                    height:
                        screenHeight *
                        0.035, // responsive height ของ progress bar
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        screenHeight * 0.018,
                      ), // responsive borderRadius
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
                        double maxWidth =
                            constraints.maxWidth -
                            screenWidth * 0.05; // responsive margin
                        double iconWidth =
                            screenWidth * 0.06; // responsive icon width

                        return Stack(
                          children: [
                            Positioned(
                              top:
                                  (screenHeight * 0.035 -
                                      screenHeight * 0.012) /
                                  2, // center line
                              left: screenWidth * 0.025,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: _calculateProgress(maxWidth),
                                height:
                                    screenHeight *
                                    0.012, // line thickness responsive
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF65A3B),
                                  borderRadius: BorderRadius.circular(
                                    screenHeight * 0.006,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left:
                                  screenWidth * 0.025 +
                                  _calculateIconPosition(maxWidth, iconWidth),
                              bottom: screenHeight * 0.003,
                              child: Container(
                                width: iconWidth,
                                height:
                                    screenHeight *
                                    0.075, // responsive icon height
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

                  const SizedBox(height: 20),

                  // วงกลมกลาง + ลูกศร (สไตล์เดิม, optional)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
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
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/head.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomPaint(
                          size: Size(screenWidth * 0.05, screenWidth * 0.025),
                          painter: _TrianglePainter(),
                        ),
                      ],
                    ),
                  ),

                  // กล่องคำถาม
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        q.question,
                        style: TextStyle(
                          fontFamily: 'Khula',
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF805E57),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // พื้นที่เล่นเกม (Stack สำหรับวาดเส้น + 2 คอลัมน์)
                  AspectRatio(
                    aspectRatio: 9 / 12,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            key: _stackKey,
                            children: [
                              // เส้นที่ยืนยันแล้ว + เส้นระหว่างลาก
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _LinesPainter(
                                    lines: _confirmedLines,
                                    tempLine: _buildTempLine(),
                                  ),
                                ),
                              ),

                              // สองคอลัมน์ (ซ้าย/ขวา)
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildSideList(
                                      options: q.leftOptions,
                                      isLeft: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildSideList(
                                      options: q.rightOptions,
                                      isLeft: false,
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

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // สร้าง temp line ระหว่างลาก
  ConnectionLine? _buildTempLine() {
    if (_draggingLeftId == null || _currentDragPos == null) return null;

    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null) return null;

    final start = _dotPositions[_draggingLeftId!];
    final end = stackBox.globalToLocal(_currentDragPos!);
    if (start == null) return null;

    // ใช้สีจาก left ที่กำลังลาก
    final leftIndex = questions[currentPage].leftOptions.indexWhere(
      (e) => e.id == _draggingLeftId!,
    );
    final color = questions[currentPage].leftOptions[leftIndex].dotColor;

    return ConnectionLine(
      leftId: _draggingLeftId!,
      rightId: '',
      start: start,
      end: end,
      color: color,
    );
  }

  // widget แสดงรายการฝั่งซ้าย/ขวา
  Widget _buildSideList({
    required List<MatchOption> options,
    required bool isLeft,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: options.map((opt) {
        return _MatchItem(
          key: ValueKey(opt.id),
          option: opt,
          dotKey: _dotKeys[opt.id]!,
          isLeft: isLeft,
          onPanStart: isLeft ? (d) => _startDrag(opt.id, d) : null,
          onPanUpdate: isLeft ? _updateDrag : null,
          onPanEnd: isLeft ? _endDrag : null,
          disabled: isLeft
              ? _connections.containsKey(opt.id)
              : _usedRight.contains(opt.id),
        );
      }).toList(),
    );
  }
}

/// ------------------------------
/// วาดเส้นทั้งหมด
/// ------------------------------
class _LinesPainter extends CustomPainter {
  final List<ConnectionLine> lines;
  final ConnectionLine? tempLine;

  _LinesPainter({required this.lines, this.tempLine});

  @override
  void paint(Canvas canvas, Size size) {
    for (final ln in lines) {
      final p = Paint()
        ..color = ln.color
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(ln.start, ln.end, p);
    }
    if (tempLine != null) {
      final p = Paint()
        ..color = tempLine!.color.withOpacity(0.9)
        ..strokeWidth =
            6 //ความหนาของเส้น
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(tempLine!.start, tempLine!.end, p);
    }
  }

  @override
  bool shouldRepaint(covariant _LinesPainter oldDelegate) {
    return oldDelegate.lines != lines || oldDelegate.tempLine != tempLine;
  }
}

/// ------------------------------
/// ไอเท็มฝั่งซ้าย/ขวา + จุดสี (anchor)
/// ฝั่งซ้ายรองรับลากนิ้ว
/// ------------------------------
// ------------------------------
// _MatchItem: ปรับขนาด icon และ dot เป็น responsive
// ------------------------------
class _MatchItem extends StatelessWidget {
  final MatchOption option;
  final GlobalKey dotKey;
  final bool isLeft;
  final bool disabled;

  final void Function(DragStartDetails details)? onPanStart;
  final void Function(DragUpdateDetails details)? onPanUpdate;
  final void Function(DragEndDetails details)? onPanEnd;

  const _MatchItem({
    Key? key,
    required this.option,
    required this.dotKey,
    required this.isLeft,
    required this.disabled,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // ✅ ปรับขนาดได้แยกกัน
    final avatarSize = screenWidth * 0.14; // ขนาดปุ่มวงกลมสีขาว
    final imageSize = screenWidth * 0.07; // ขนาดรูปภาพด้านใน

    final dotSize = screenWidth * 0.03;
    final iconSpacing = screenWidth * 0.001;

    final avatar = Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          option.iconPath,
          width: imageSize, // ✅ ขนาดรูป
          height: imageSize, // ✅ ขนาดรูป
          fit: BoxFit.contain,
        ),
      ),
    );

    final dot = Container(
      key: dotKey,
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: option.dotColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );

    final row = Row(
      mainAxisAlignment: isLeft
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isLeft) dot,
        SizedBox(width: iconSpacing),
        ColorFiltered(
          colorFilter: disabled
              ? const ColorFilter.mode(Colors.black26, BlendMode.srcATop)
              : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: avatar,
        ),
        SizedBox(width: iconSpacing),
        if (isLeft) dot,
      ],
    );

    final gesture = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: disabled ? null : onPanStart,
      onPanUpdate: disabled ? null : onPanUpdate,
      onPanEnd: disabled ? null : onPanEnd,
      child: row,
    );

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.14,
        right: screenWidth * 0.14,
        top: (screenHeight - 20) * 0.001,
        bottom: (screenHeight - 20) * 0.001,
      ),
      child: gesture,
    );
  }
}

/// สามเหลี่ยมตกแต่งใต้โปรไฟล์กลาง (เหมือนต้นแบบ)
class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
