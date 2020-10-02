import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrderScreen extends StatefulWidget {
  static const ROUTE_NAME = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // NOTE: this approach is prevent for rendering again to widget and this approach can be done if
  // on this class doesn't implement updating data
  Future _ordersFuture;

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context).orders;

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: SideDrawer(SelectedDrawer.Orders),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(child: Text('An error has occured'));
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) {
                    return ListView.builder(
                      itemBuilder: (ctx, idx) =>
                          OrderItem(orderData.orders[idx]),
                      itemCount: orderData.orders.length,
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
