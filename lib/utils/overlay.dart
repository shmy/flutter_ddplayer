import 'package:flutter/material.dart';

typedef OverlayStateRemove = void Function();

class DdOverlay {
  static OverlayState _overlayState;
  static OverlayEntry _overlayEntry;
  static void show(BuildContext context, Widget widget) {
    _overlayState = Overlay.of(context);
    _overlayEntry = new OverlayEntry(builder: (context) {
      return Column(
        children: <Widget>[
          Expanded(
            child: IgnorePointer(),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              bottom: 5.0,
            ),
            height: 80.0,
            width: double.infinity,
            child: widget,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0xbbbbbbbb),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5.0,
                ),
                BoxShadow(
                  color: Color(0xbbbbbbbb),
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
          )
        ],
      );
    });
    _overlayState.insert(_overlayEntry);
  }
  static void hide() {
    _overlayEntry?.remove();
//    _overlayState?.dispose();
    _overlayState = null;
    _overlayEntry = null;
  }
}
