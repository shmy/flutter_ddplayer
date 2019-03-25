import 'dart:async';
import './defs.dart';

class DdPlayerDlna {

  static StreamSubscription eventSubscription;

  static init(cb) {
    eventSubscription =
        eventChannel.receiveBroadcastStream().listen((dynamic data) {
          cb(data);
        });
  }

  static Future<List<dynamic>> get devices async {
    final List<dynamic> devices =
    await methodChannel.invokeMethod('dlna:getList');
    return devices;
  }

  static search() async {
    await methodChannel.invokeMethod('dlna:search');
  }

  static stop() async {
    await methodChannel.invokeMethod('dlna:stop');
  }

  static playUrl(String uuid, String url) async {
    await methodChannel.invokeMethod('dlna:playUrl', {
      "uuid": uuid,
      "url": url,
    });
  }
}
