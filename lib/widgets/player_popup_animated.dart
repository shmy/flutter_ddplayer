import 'package:flutter/material.dart';

class PlayerPopupAnimated extends AnimatedWidget {
  double width = 0.0;
  Widget child;

  PlayerPopupAnimated(
      {Key key,
        @required Animation<double> animation,
        @required this.width,
        @required this.child})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Positioned(
      right: animation.value,
      top: 0.0,
      bottom: 0.0,
      width: width,
      child: Container(
        color: Colors.teal,
        child: child,
      ),
    );
  }
}
