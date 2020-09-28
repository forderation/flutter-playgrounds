import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final String title;
  // required decorator can be import by flutter/foundation
  Transaction(
      {@required this.id,
      @required this.amount,
      @required this.date,
      @required this.title});
}
