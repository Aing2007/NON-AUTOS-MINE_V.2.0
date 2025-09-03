import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  /// Register with email & password + save user info to database
  Future<User?> register({
    required String email,
    required String password,
    required String? name,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Save user basic info into Realtime Database
        await _dbRef.child("users/${user.uid}").set({
          "uid": user.uid,
          "email": user.email,
          "name": name,
          "createdAt": DateTime.now().toIso8601String(),
        });
      }

      return user;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  /// Sign in with email & password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Sign in error: $e");
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Sign out error: $e");
      return;
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Listen auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
