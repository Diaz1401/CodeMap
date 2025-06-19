import 'package:flutter/foundation.dart';

class Util {
  static void printDebug(String tag, String message) {
    if (kDebugMode) {
      debugPrint("CodeMap DEBUG: $tag: $message", wrapWidth: 1024);
    }
  }
}