import 'package:dd_player/channel/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const CHANNEL_NAME = "tech.shmy.plugins/dd_player/";
const MethodChannel methodChannel =
const MethodChannel(CHANNEL_NAME + "method_channel");
const EventChannel eventChannel =
const EventChannel(CHANNEL_NAME + "event_channel");


enum PopupType { none, dlna, other }

void setNormallyOn() async {
  print("==========setNormallyOn===========");
  await DdPlayerScreen.setNormallyOn();
}

void unSetNormallyOn() async {
  print("==========unSetNormallyOn===========");
  await DdPlayerScreen.unSetNormallyOn();
}

var cpi = CircularProgressIndicator(
  strokeWidth: 2.0,
  valueColor: AlwaysStoppedAnimation<Color>(
    Colors.white70,
  ),
);