import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  Future<void> _submitAuthForm(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      // perform image upload to firebase storage
      // user_image automaticcly create
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authResult.user.uid + '.jpeg');
      // ref is return pointer to some ath related on user id

      // add oncomplete to get future and know this completed upload
      await ref.putFile(image).onComplete;

      // url from firebase storage
      final imageUrl = await ref.getDownloadURL();

      // collection automate iniate if not exist on firebase database
      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData(
        {'username': username, 'email': email, 'image_url': imageUrl},
      );

      // PlatformException is provided by Firebase
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      // development error
      print(err);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(isLoading, _submitAuthForm),
    );
  }
}
