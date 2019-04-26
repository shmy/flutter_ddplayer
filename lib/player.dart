import 'package:dd_player/defs.dart';
import 'package:dd_player/widgets/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';


class DdPlayer extends StatefulWidget {
  String url;
  Widget thumbnail;
  Function listener;
  bool enableDLNA;
  bool enablePip;
  bool enableFixed;

  DdPlayer({
    Key key,
    @required this.url,
    this.thumbnail,
    this.listener,
    this.enableDLNA = false,
    this.enablePip = false,
    this.enableFixed = false,
  });

  @override
  _DdPlayer createState() => _DdPlayer();
}

class _DdPlayer extends State<DdPlayer> {
  VideoPlayerController _videoPlayerController;

  Widget build(BuildContext context) {
    return VideoView(
      controller: _videoPlayerController,
      thumbnail: widget.thumbnail,
      listener: widget.listener,
      enableDLNA: widget.enableDLNA,
      enablePip: widget.enablePip,
      enableFixed: widget.enableFixed,
    );
  }

  void _buildPlayer() {
    if (widget.url == "") {
      return;
    }
    if (_videoPlayerController != null) {
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
    }
    _videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setNormallyOn();
        _videoPlayerController.play();
      });
  }

  void initState() {
    _buildPlayer();
    super.initState();
  }

  @override
  void didUpdateWidget(DdPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _buildPlayer();
    }
  }

//  @override
//  void dispose() {
//    if (!widget.enableFixed && _videoPlayerController != null) {
//      unSetNormallyOn();
//      _videoPlayerController.dispose();
//      _videoPlayerController = null;
//    }
//    super.dispose();
//  }
}
