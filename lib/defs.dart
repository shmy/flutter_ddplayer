import 'package:flutter/services.dart';
const CHANNEL_NAME = "tech.shmy.plugins/dd_player/";
const MethodChannel methodChannel =
const MethodChannel(CHANNEL_NAME + "method_channel");
const EventChannel eventChannel =
const EventChannel(CHANNEL_NAME + "event_channel");