import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final FlutterTts _flutterTts = FlutterTts();

  // ฟังก์ชันเริ่มต้น (เรียกครั้งเดียว)
  static Future<void> init() async {
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.setVolume(5.0); // ค่า default
  }

  // ฟังก์ชันพูด
  static Future<void> speak(
    String text, {
    double rate = 0.5,
    double pitch = 1.0,
  }) async {
    await _flutterTts.setSpeechRate(rate);
    await _flutterTts.setPitch(pitch);
    await _flutterTts.speak(text);
  }

  // หยุด
  static Future<void> stop() async {
    await _flutterTts.stop();
  }
}
