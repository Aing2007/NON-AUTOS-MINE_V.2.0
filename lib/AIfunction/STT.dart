import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  static final stt.SpeechToText _speech = stt.SpeechToText();
  static bool _isInitialized = false;

  /// เริ่มต้นระบบ Speech
  static Future<void> init() async {
    if (!_isInitialized) {
      await _speech.initialize();
      _isInitialized = true;
    }
  }

  /// เริ่มฟังเสียง
  static Future<void> startListening(Function(String) onResult) async {
    await init();
    _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
      localeId: "th-TH", // ✅ ภาษาไทย
    );
  }

  /// หยุดฟังเสียง
  static Future<void> stopListening() async {
    await _speech.stop();
  }

  /// ยกเลิกการฟัง
  static Future<void> cancelListening() async {
    await _speech.cancel();
  }
}
