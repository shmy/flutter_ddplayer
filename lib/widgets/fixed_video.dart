import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef FixedVideoCloseTaped = void Function();
typedef FixedVideoPlayerTaped = void Function();

class FixedVideo extends StatefulWidget {
  FixedVideo(
      {Key key,
      @required this.videoPlayerController,
      @required this.fixedVideoCloseTaped,
      @required this.fixedVideoPlayerTaped})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final FixedVideoCloseTaped fixedVideoCloseTaped;
  final FixedVideoPlayerTaped fixedVideoPlayerTaped;

  @override
  _FixedVideoState createState() => _FixedVideoState();
}

class _FixedVideoState extends State<FixedVideo> {
  VideoPlayerController get _videoPlayerController =>
      widget.videoPlayerController;

  FixedVideoCloseTaped get _fixedVideoCloseTaped => widget.fixedVideoCloseTaped;

  FixedVideoPlayerTaped get _fixedVideoPlayerTaped =>
      widget.fixedVideoPlayerTaped;

//  bool get _isPlaying
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
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
          Expanded(
            child: Container(
              child: Text(
                "登记卡活动时登记卡活动时的快乐撒娇地撒开了n的快乐撒娇地撒开了登记卡活动时登记卡活动时的快乐撒娇地撒开了n的快乐撒娇地撒开了",
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
          ),
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
                  onPressed: _fixedVideoCloseTaped,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _videoPlayerController.addListener(() {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }
}
