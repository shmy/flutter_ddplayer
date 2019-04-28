import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef FixedVideoCloseTaped = void Function(dynamic);
typedef FixedVideoPlayerTaped = void Function(dynamic);

class FixedVideo extends StatefulWidget {
  FixedVideo(
      {Key key,
      @required this.videoPlayerController,
      @required this.fixedVideoCloseTaped,
      @required this.fixedVideoPlayerTaped,
      @required this.listener,
      @required this.pageState,
      this.videoTitle = ""})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final FixedVideoCloseTaped fixedVideoCloseTaped;
  final FixedVideoPlayerTaped fixedVideoPlayerTaped;
  final Function listener;
  final dynamic pageState;
  final String videoTitle;

  @override
  _FixedVideoState createState() => _FixedVideoState();
}

class _FixedVideoState extends State<FixedVideo> {
  VideoPlayerController get _videoPlayerController =>
      widget.videoPlayerController;

  FixedVideoCloseTaped get _fixedVideoCloseTaped => widget.fixedVideoCloseTaped;

  FixedVideoPlayerTaped get _fixedVideoPlayerTaped =>
      widget.fixedVideoPlayerTaped;

  Function get _listener => widget.listener;

  dynamic get _pageState => widget.pageState;

  String get _videoTitle => widget.videoTitle;

  double get _position {
    var controllerValue = _videoPlayerController.value;
    if (controllerValue == null ||
        controllerValue.position == null ||
        controllerValue.duration == null) {
      return 0.0;
    }
    var dl =
        controllerValue.position.inSeconds / controllerValue.duration.inSeconds;
    return dl * MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: _videoPlayerController == null
                          ? Container(
                              color: Colors.black,
                            )
                          : VideoPlayer(_videoPlayerController),
                    ),
                  ),
                  onTap: () => _fixedVideoPlayerTaped(_pageState),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () => _fixedVideoPlayerTaped(_pageState),
                  child: Container(
                    child: Text(
                      _videoTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      5.0,
                    ),
                  ),
                )),
//
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(
                          _videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 30.0,
                        ),
                        onPressed: () {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                        },
                      ),
                      IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                        ),
                        onPressed: () => _fixedVideoCloseTaped(_pageState),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 进度条
          Container(
            color: Colors.white,
            height: 2.0,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
              width: _position,
              height: 2.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _videoPlayerController?.addListener(listener);
    super.initState();
  }

//  @override
//  void dispose() {
//    _videoPlayerController.removeListener(listener);
//    super.dispose();
//  }

  listener() {
    if (!mounted) {
      return;
    }
    if (_listener != null) {
      _listener(_videoPlayerController);
    }
    try {
      setState(() {});
    } catch (e) {
      //
    }
  }
}
