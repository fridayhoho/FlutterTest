import 'dart:async';
import 'dart:typed_data';
import 'home_contract.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeModel implements Model {

  List<Item> _items;

  Map<Item,Map<int, Uint8List>> _images;

  @override
  Future<Item> getImageForItem(Item item) async {
    // For this tutorial, we retrieve images from assets

    Map<int, Uint8List> imagesForItem = new Map<int, Uint8List>();

    if (item.numImages > 0) {
      // For now, we get the first image only
      Uint8List firstImageForItem = (await rootBundle.load('assetss/1.png')).buffer.asUint8List();
      imagesForItem.putIfAbsent(1, () => firstImageForItem);
      _images.putIfAbsent(item, () => imagesForItem);
      item.currentImage = firstImageForItem;
      item.currentImageNumber = 1;
    }

    return item;
  }

  @override
  Future<List<Item>> getItems() async {

    // For this tutorial, we simulate a delay as you would get when calling a backend
    await new Future.delayed(new Duration(seconds: 2));

    // For this tutorial, we use hard coded data
    _items = new List<Item>();
    _items.add(new Item(1, "Item 1", 3));
    _items.add(new Item(2, "Item 2", 1));
    _items.add(new Item(3, "Item 3", 0));
    _items.add(new Item(4, "Item 4", 1));
    _items.add(new Item(5, "Item 5", 4));
    _items.add(new Item(6, "Item 6", 2));
    _items.add(new Item(7, "Item 7", 5));
    _items.add(new Item(8, "Item 8", 1));
    _items.add(new Item(9, "Item 9", 1));
    _items.add(new Item(10, "Item 10", 1));
    _items.add(new Item(11, "Item 11", 1));
    _items.add(new Item(12, "Item 12", 0));
    _items.add(new Item(13, "Item 13", 4));
    _items.add(new Item(14, "Item 14", 2));
    _items.add(new Item(15, "Item 15", 1));

    _images = new Map<Item, Map<int, Uint8List>>();

    return _items;

  }
}