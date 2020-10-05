import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/models/http-error.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String segment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/$segment?key=AIzaSyCIZhSUPtcaM5NbbM7ZmujjTdjufgAGLZQ';
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpError(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }
}
