import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http-error.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      // default init
      this.isFavorite = false});

  Future<void> toggleFavorite() async {
    final url = 'https://mandor-pulsa-odqply.firebaseio.com/products/$id.json';
    final oldStatus = isFavorite;
    isFavorite = !oldStatus;
    notifyListeners();
    final response = await http.patch(url,
        body: json.encode({
          'isFavorite': !oldStatus,
        }));
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpError('Something wrong to change favorite status');
    }
  }
}
