import './defs.dart';

class DdPlayerScreen {
  static setNormallyOn() async {
    await methodChannel.invokeMethod('screen:setNormallyOn');
  }
  static unSetNormallyOn() async {
    await methodChannel.invokeMethod('screen:unSetNormallyOn');
  }
}