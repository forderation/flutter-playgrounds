import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    // NOTE: Animated Container Doesn't need controller animation
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 110, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
                title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
                subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                    .format(widget.order.dateTime)),
                trailing: IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    })),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 10, 180)
                  : 0,
              child: ListView(
                children: widget.order.products
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('${e.quantity}x \$${e.price}')
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
