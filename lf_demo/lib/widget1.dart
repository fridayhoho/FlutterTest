import 'package:flutter/material.dart';

class Widget1 extends StatefulWidget {
  Widget1({Key key}) : super(key: key);

  @override
  _Widget1State createState() => new _Widget1State();

}

class _Widget1State extends State<Widget1> {

  @override
  Widget build(BuildContext context) {
    return new Card(
        margin: const EdgeInsets.all(8.0),
        child: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Text('Widget 1 not implemented yet'),
        ),
    );
  }

}