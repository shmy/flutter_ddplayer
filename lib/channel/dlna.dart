import 'dart:async';
import 'package:dd_player/defs.dart';

class DdPlayerDlna {
  static StreamSubscription eventSubscription;

  static init(cb) {
    eventSubscription =
        eventChannel.receiveBroadcastStream().listen((dynamic data) {
      cb(data);
    });
  }

  static Future<List<dynamic>> get devices async {
    try {
      final List<dynamic> devices =
          await methodChannel.invokeMethod('dlna:getList');
      return devices;
    } on Exception catch (_) {
      return [];
    }
  }

  static Future<Null> search() async {
    await methodChannel.invokeMethod('dlna:search');
    return null;
  }

  static Future<Null> stop() async {
    await methodChannel.invokeMethod('dlna:stop');
    return null;
  }

  static playUrl(String uuid, String url) async {
    await methodChannel.invokeMethod('dlna:playUrl', {
      "uuid": uuid,
      "url": url,
    });
  }
}
