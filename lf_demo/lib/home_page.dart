import 'package:flutter/material.dart';
import 'home_contract.dart';
import 'home_model.dart';
import 'home_presenter.dart';

class _TheHomePageState extends State<TheHomePage> implements View {
  List<Item> _items;

  HomePresenter _presenter;

  bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
    _presenter = new HomePresenter(new HomeModel(), this);
    _presenter.viewDisplayed();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.orangeAccent, title: new Text('data')),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    if (_loadingInProgress) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: _items.map((Item item) {
          return _buildListRow(item);
        }).toList(),
      );
    }
  }

  Widget _buildListRow(Item item) {
    return new Container(
        margin: new EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(child: new Text(item.title)),
            new Container(
                width: 100.0,
                height: 100.0,
                child: item.currentImage != null
                    ? new Image.memory(item.currentImage)
                    : new Center(child: new Text('Image not available')))
          ],
        ));
  }

  @override
  void showImageForItem(Item item) {
    setState(() {
      for (var it in _items) {
        if (it.id == item.id) {
          it.currentImage = item.currentImage;
        }
      }
      _loadingInProgress = false;
    });
  }

  @override
  void showItems(List<Item> items) {
    setState(() {
      _items = items;
      _loadingInProgress = false;
    });
  }
}

class TheHomePage extends StatefulWidget {
  TheHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TheHomePageState createState() => new _TheHomePageState();
}
