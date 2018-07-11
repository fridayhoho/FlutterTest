import 'package:flutter/material.dart';

class Widget2 extends StatefulWidget {
  Widget2({Key key}) : super(key: key);

  @override
  _Widget2State createState() => new _Widget2State();

}

class _Widget2State extends State<Widget2> {

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: const EdgeInsets.all(8.0),
      child: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Text('Widget 2 not implemented yet'),
      ),
    );
  }

}