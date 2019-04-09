import 'package:dd_player/player.dart';
import 'package:dd_player/screen.dart';
import 'package:flutter/material.dart';
class Player extends StatefulWidget {
  @override
  PlayerState createState() => new PlayerState();
}

class PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
      body: DdPlayer(url: "https://hair.jingpin88.com/20171029/Fillu3JT/index.m3u8", enableDLNA: true, enablePip: true,),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    setNormallyOn();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    unSetNormallyOn();
    super.dispose();
  }

  @override
  void didUpdateWidget(Player oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}