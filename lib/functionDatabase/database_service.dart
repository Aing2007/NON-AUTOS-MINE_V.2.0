import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  /// Create (เขียนข้อมูลใหม่ที่ path กำหนด → set แทนที่ข้อมูลเดิม)
  Future<void> create({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  /// Read once (อ่านข้อมูลครั้งเดียว)
  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  /// Update (อัพเดทเฉพาะ field ที่ส่งมา → ไม่ลบข้อมูล field อื่น)
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  /// Overwrite (เขียนทับข้อมูลทั้งหมดที่ path → ใช้ set())
  Future<void> overwrite({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.set(data);
  }

  /// Delete (ลบข้อมูลที่ path)
  Future<void> delete({required String path}) async {
    DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }

  /// Read as Stream (ติดตามค่าที่เปลี่ยนแปลงแบบเรียลไทม์)
  Stream<DatabaseEvent> stream({required String path}) {
    DatabaseReference ref = _firebaseDatabase.ref().child(path);
    return ref.onValue;
  }
}
