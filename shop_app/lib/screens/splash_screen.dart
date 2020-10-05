import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Waiting...'),
            )
          ],
        ),
      ),
    );
  }
}
