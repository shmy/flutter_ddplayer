import 'package:dd_player/defs.dart';

class DdPlayerVolume {
  static Future<int> get currentVolume async {
    return await methodChannel.invokeMethod('volume:getCurrentVolume');
  }
  static Future<int> get maxVolume async {
    return await methodChannel.invokeMethod('volume:getMaxVolume');
  }

  static Future<int> incrementVolume() async {
    return await methodChannel.invokeMethod('volume:incrementVolume');
  }

  static Future<int> decrementVolume() async {
    return await methodChannel.invokeMethod('volume:decrementVolume');
  }
}
