
import 'package:flutter/material.dart';

typedef LifecycleEventHandlerCallback = void Function(AppLifecycleState);
class LifecycleEventHandler extends WidgetsBindingObserver {

  LifecycleEventHandler({@required this.cb});

  final LifecycleEventHandlerCallback cb;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    cb(state);
  }
}
