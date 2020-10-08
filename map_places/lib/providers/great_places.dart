import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:map_places/helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
      File pickedImage, String pickedTitle, PlaceLocation pickedLocation) {
    // TODO: use address automatically get by geocoding gmap api with await
    final updatedLocation = new PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address:
            "Dumb Adress piece of classical Latin literature from 45 BC, making it over 2000 years old");
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: updatedLocation,
        title: pickedTitle);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((placeMap) => Place(
            id: placeMap['id'],
            title: placeMap['title'],
            image: File(placeMap['image']),
            location: new PlaceLocation(
                address: placeMap['address'],
                latitude: placeMap['loc_lat'],
                longitude: placeMap['loc_lng'])))
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
