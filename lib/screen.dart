import './defs.dart';

class DdPlayerScreen {

  static Future<int> get currentBrightness async {
    return await methodChannel.invokeMethod('screen:getBrightness');
  }

  static setNormallyOn() async {
    await methodChannel.invokeMethod('screen:setNormallyOn');
  }
  static unSetNormallyOn() async {
    await methodChannel.invokeMethod('screen:unSetNormallyOn');
  }

  static Future<int> incrementBrightness() async {
    return await methodChannel.invokeMethod('screen:incrementBrightness');
  }

  static Future<int> decrementBrightness() async {
    return await methodChannel.invokeMethod('screen:decrementBrightness');
  }
  static enterPip() async {
    return await methodChannel.invokeMethod('screen:enterPip');
  }
}