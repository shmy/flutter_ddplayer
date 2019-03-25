import 'package:dd_player/player.dart';
import 'package:flutter/material.dart';
class  Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: DdPlayer(url: "https://cv.phncdn.com/videos/201901/28/204302121/720P_1500K_204302121.mp4?UeToNXSVhVkcjRj-Pkep1eg8OS6dXzfSSdpciRhGvbOFRuXXA7uf4joWObAQOv8DhAzjfRNT6Nbk8SpnJ6pGp7_y-knzPTVaE2yS_6wR5xDqtvVkQ51Pyhnv7rq-U6q4tZCRvho7uz3bc_XbZtClXWs34T79aXqQdslXyi7JX-5kEEly7pnyM0KrSJ7D-h1zT9MLYLBtTA0",),
        ),
    );
  }
}