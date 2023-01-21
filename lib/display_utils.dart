import 'package:flutter/foundation.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock/wakelock.dart';

class DisplayUtils {
  static Future<void> enableKeepOn() async {
    return Wakelock.enable();
  }

  static Future<void> disableKeepOn() async {
    return Wakelock.disable();
  }

  static Future<double> get systemBrightness async {
    try {
      return await ScreenBrightness().system;
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to get system brightness';
    }
  }

  static Future<double> get currentBrightness async {
    try {
      return await ScreenBrightness().current;
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to get current brightness';
    }
  }

  static Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set brightness';
    }
  }
}
