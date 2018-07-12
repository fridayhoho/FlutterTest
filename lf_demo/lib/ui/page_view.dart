import 'package:flutter/material.dart';
import 'dart:async';
class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> with WidgetsBindingObserver{
  bool _isAddGradient = false;
  final int imgCounts = 5;
  var timer;
  @override
  void initState() {
    super.initState();
    // void callback
    WidgetsBinding.instance.addObserver(this);
    print('---initstate');
    timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer){
      var date = new DateTime.now().millisecondsSinceEpoch;
      
      print(date.toString()+' $date'); 
    });
    
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state:$state');
    if (state == AppLifecycleState.paused) {
      timer.cancel();
    }else if(state == AppLifecycleState.resumed){
      // timer.resume();
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print('dispose');
    timer.cancel();
  }
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
