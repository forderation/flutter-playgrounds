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

  Future<void> toggleFavorite(String token, String userId) async {
    final url =
        'https://mandor-pulsa-odqply.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    final oldStatus = isFavorite;
    isFavorite = !oldStatus;
    notifyListeners();
    // NOTE: using patch for old approatch is good
    // but in thaht's case to favorite relate on user, use put
    final response = await http.put(url, body: json.encode(isFavorite));
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpError('Something wrong to change favorite status');
    }
  }
}
