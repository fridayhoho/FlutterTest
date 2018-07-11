import 'package:flutter/material.dart';
import 'package:lf_demo/data/data_repo.dart';
import 'dart:async';

class Widget1 extends StatefulWidget {
  Widget1({Key key}) : super(key: key);

  @override
  _Widget1State createState() => new _Widget1State();

}

class _Widget1State extends State<Widget1> {

  ExchangeRates _exchangeRates ;
 
  bool _loading;
  String _toShow = 'fetching...';
  @override
  void initState() {
    super.initState();
    _loading = true;
    
    // getWorldCupNews();
    // getChampionLeageNews();


    dataRepository.getExchangeRates().then((result) {
      print("resultBK:");
      print(result);
      if (result == null) {
        return;
      }
      
      setState(() {
        _exchangeRates = result;
        _loading = false;
        _toShow = _exchangeRates.rateGBP.currencyDisplay.toString() + _exchangeRates.rateGBP.rate.toString();
      });

      
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Card(
        margin: const EdgeInsets.all(8.0),
        child: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new Text(_toShow),
        ),
    );
  }

}
void getWorldCupNews() async{
  await new Future.delayed(new Duration(seconds: 2));
  print('getWorldCupNews');
}


Future getChampionLeageNews() async{
  await new Future.delayed(new Duration(seconds: 1));
  print('getChampionLeageNews');
}