

import 'package:flutter/material.dart';

class SlideTransitionBar extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final bool isBottom;

  SlideTransitionBar(
      {Key key,
        @required this.child,
        @required this.animation,
        this.isBottom = false}) : super(key: key);

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        if (isBottom) {
          return Positioned(
            bottom: animation.value,
            left: 0.0,
            right: 0.0,
            child: child,
          );
        }
        return Positioned(
          top: animation.value,
          left: 0.0,
          right: 0.0,
          child: child,
        );
      },
      child: child,
    );
  }
}
