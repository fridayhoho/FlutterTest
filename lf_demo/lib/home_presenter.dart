import 'home_contract.dart';
import 'dart:async';

class HomePresenter implements Presenter {

  Model _model;

  View _view;

  bool _active;
  HomePresenter(this._model, this._view);

  @override
  Future viewDisplayed() async {
    _active = true;
    List<Item> items = await _model.getItems();
    _view.showItems(items);
    for (var item in items) {
      _view.showImageForItem(await _model.getImageForItem(item));
    }
    _loopThroughImages();
  }

  Future _loopThroughImages() async {
    await new Future.delayed(new Duration(seconds:  2));
 
    List<Item> items = await _model.getItems();
    for (var item in items) {
      Item updatedItem = await _model.getImageForItem(item);
      if (_active) {
        _view.showImageForItem(updatedItem);
      } else {
        return;
      }
    }
 
    _loopThroughImages();
  }

  @override
  void viewDisposed() {
    _active = false;
  }
}