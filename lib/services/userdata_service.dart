import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UserdataService {
  final _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;

  String _sanitizeEmail(String email) => email.replaceAll('.', ',');

  Future<Map<String, dynamic>> getUserRequestData() async {
    final user = _auth.currentUser;
    if (user == null) return {};
    final email = _sanitizeEmail(user.email!);
    final snapshot = await _db.child('users/$email').get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return {};
  }

  Future<bool> canAnalyze() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    final email = _sanitizeEmail(user.email!);
    final now = DateTime.now();
    final snapshot = await _db.child('users/$email').get();
    int count = 0;
    DateTime? lastTime;
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      count = data['count'] ?? 0;
      final lastDateStr = data['date'];
      if (lastDateStr != null) {
        lastTime = DateTime.tryParse(lastDateStr);
      }
    }
    if (lastTime == null || now.difference(lastTime).inHours >= 6) {
      // Reset count for new 6-hour window
      await _db.child('users/$email').set({'count': 0, 'date': now.toIso8601String()});
      count = 0;
    }
    return count < 10;
  }

  Future<void> incrementAnalyzeCount() async {
    final user = _auth.currentUser;
    if (user == null) return;
    final email = _sanitizeEmail(user.email!);
    final now = DateTime.now();
    final snapshot = await _db.child('users/$email').get();
    int count = 0;
    DateTime? lastTime;
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      count = data['count'] ?? 0;
      final lastDateStr = data['date'];
      if (lastDateStr != null) {
        lastTime = DateTime.tryParse(lastDateStr);
      }
    }
    if (lastTime == null || now.difference(lastTime).inHours >= 6) {
      count = 0;
    }
    count++;
    await _db.child('users/$email').set({'count': count, 'date': now.toIso8601String()});
  }
}