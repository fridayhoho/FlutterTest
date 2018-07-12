import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool _isAddGradient = false;
  final int imgCounts = 5;
  ///
  ///@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(context),
    );
  }

  Widget buildPageView(BuildContext context){
    return Padding(
        padding: new EdgeInsets.only(top: 50.0),
        child: SizedBox.fromSize(
          size: Size.fromHeight(200.0),
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: imgCounts,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 5.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.lightGreen,
                          duration: Duration(milliseconds: 800),
                          content: Center(
                            child: Text(
                              '开发中',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ));
                  },
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assetss/a' + (index+1).toString() + '.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
