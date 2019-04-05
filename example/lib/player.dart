import 'package:dd_player/player.dart';
import 'package:dd_player/screen.dart';
import 'package:flutter/material.dart';
class  Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
        body: DdPlayer(url: "https://hair.jingpin88.com/20171029/Fillu3JT/index.m3u8",),
    );
  }
}