import 'dart:async';
import 'dart:typed_data';
import 'home_contract.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeModel implements Model {
  List<Item> _items;

  Map<Item, Map<int, Uint8List>> _images;

  @override
  Future<Item> getImageForItem(Item item) async {
    // For this tutorial, we retrieve images from assets

    if (item.numImages > 0) {
      // Initialise at first image
      int imageNumberToGet = 1;

      // If we already have a current image in memory, get the next one available for the item, or go back to the first one
      if (item.currentImageNumber != null) {
        imageNumberToGet = item.currentImageNumber + 1;
        if (imageNumberToGet > item.numImages) {
          imageNumberToGet = 1;
        }
      }

      // Do we have image already?
      if (_images.containsKey(item) &&
          _images[item].containsKey(imageNumberToGet)) {
        item.currentImage = _images[item][imageNumberToGet];
        item.currentImageNumber = imageNumberToGet;
      } else {
        // Get image from assets
        Uint8List imageForItem = (await rootBundle
                .load('assetss/' + imageNumberToGet.toString() + '.png'))
            .buffer
            .asUint8List();
        if (_images.containsKey(item)) {
          _images[item].putIfAbsent(imageNumberToGet, () => imageForItem);
        } else {
          Map<int, Uint8List> imagesForItem = new Map<int, Uint8List>();
          imagesForItem.putIfAbsent(imageNumberToGet, () => imageForItem);
          _images.putIfAbsent(item, () => imagesForItem);
        }
        item.currentImage = imageForItem;
        item.currentImageNumber = imageNumberToGet;
      }
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
