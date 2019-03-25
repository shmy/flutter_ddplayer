import 'dart:async';

import 'package:flutter/services.dart';

class DdPlayerDlna {
  static const CHANNEL_NAME = "tech.shmy.plugins/dd_player/";
  static const MethodChannel methodChannel =
  const MethodChannel(CHANNEL_NAME + "method_channel");
  static const EventChannel eventChannel =
  const EventChannel(CHANNEL_NAME + "event_channel");
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
