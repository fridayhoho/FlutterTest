import 'package:flutter/material.dart';
import 'package:lf_demo/widget1.dart';
import 'package:lf_demo/widget2.dart';

class TestFuturePage extends StatefulWidget {
  TestFuturePage({Key key}) : super(key: key);

  @override
  _TestFuturePageState createState() => new _TestFuturePageState();

}

class _TestFuturePageState extends State<TestFuturePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Async Code Example"),
      ),
      body: new ListView(
        children: <Widget>[
          new Widget1(),
          new Widget2()
        ],
      ),
    );
  }
}