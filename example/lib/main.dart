import 'package:dd_player/screen.dart';
import 'package:dd_player_example/player.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: IndexPage()
      ),
    );
  }
}
class IndexPage extends StatelessWidget {
  Widget build (BuildContext context) {
    return ListView(
      children: [
        MaterialButton(
            child: Text("press me"),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                return new Player();
              }));
            }),
        MaterialButton(
            child: Text("pip"),
            onPressed: () {
              DdPlayerScreen.enterPip();
            }),
      ]
    );
  }
}
