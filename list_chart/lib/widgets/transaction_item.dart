import 'dart:math';

import 'package:flutter/material.dart';
import 'package:list_chart/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tx;
  final Function deleteFunction;

  TransactionItem({Key key, this.tx, this.deleteFunction}) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  Color _bgColor;

  @override
  void initState() {
    final availableColors = [
      Colors.purpleAccent,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.red
    ];

    _bgColor = availableColors[Random().nextInt(5)];

    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return FadeTransition(
        opacity: animation,
        child: Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _bgColor,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${widget.tx.amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ),
              title: Text(widget.tx.title,
                  style: Theme.of(context).textTheme.headline6),
              subtitle: Text(DateFormat.yMMMd().format(widget.tx.date)),
              trailing: MediaQuery.of(context).size.width > 400
                  ? FlatButton.icon(
                      onPressed: () => widget.deleteFunction(widget.tx.id),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      textColor: Theme.of(context).errorColor,
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => widget.deleteFunction(widget.tx.id)),
            )));
  }
}
