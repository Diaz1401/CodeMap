import 'package:flutter/foundation.dart';

class Util {
  static void printDebug(String tag, String message) {
    if (kDebugMode) {
      print("CodeMap DEBUG: $tag: $message");
    }
  }
}