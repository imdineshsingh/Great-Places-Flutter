import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app_flutter/helpers/db_helper.dart';
import 'package:places_app_flutter/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    //return copy of _items
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: null,
        image: pickedImage);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    dataList.map((item) => Place(id: item['id'],title: item['title'],image: File(item['image']),location: null)).toList();
  }
}
