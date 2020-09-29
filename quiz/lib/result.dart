import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int scoreResult;
  final Function resetHandler;

  Result(this.scoreResult, this.resetHandler);

  String get scorePhrase {
    String scoreText;
    if (scoreResult <= 8) {
      scoreText = "Score result 8";
    } else if (scoreResult <= 10) {
      scoreText = "Score result 10";
    } else {
      scoreText = "Score result else";
    }
    return scoreText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          scorePhrase,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          textAlign: TextAlign.center,
        ),
        FlatButton(
            onPressed: resetHandler,
            child: Text(
              'Reset Quiz',
              style: TextStyle(color: Colors.blue),
            ))
      ],
    ));
  }
}
