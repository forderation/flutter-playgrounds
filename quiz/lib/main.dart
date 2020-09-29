import 'package:flutter/material.dart';
import './result.dart';
import './quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  static const _questions = [
    {
      'question': 'What\'s your favorite color ?',
      'answer': [
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 4},
        {'text': 'Blue', 'score': 1},
        {'text': 'Red', 'score': 2}
      ],
    },
    {
      'question': 'What\'s your favorite animal ?',
      'answer': [
        {'text': 'Cat', 'score': 3},
        {'text': 'Dog', 'score': 4},
        {'text': 'Bird', 'score': 2},
        {'text': 'Fish', 'score': 6}
      ],
    },
    {
      'question': 'What\'s your favorite hobbies ?',
      'answer': [
        {'text': 'Jogg', 'score': 3},
        {'text': 'Sleep', 'score': 2},
        {'text': 'Code', 'score': 1},
        {'text': 'Writing', 'score': 4}
      ],
    }
  ];

  void _resetScore() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex += 1;
    });

    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold base structure for draw widget
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Our First Application'),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                )
              : Result(_totalScore, _resetScore)),
    );
  }
}
