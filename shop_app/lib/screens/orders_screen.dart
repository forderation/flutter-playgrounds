import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrderScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: SideDrawer(SelectedDrawer.Orders),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orders[i]),
        itemCount: orders.length,
      ),
    );
  }
}
