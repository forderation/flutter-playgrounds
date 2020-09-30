import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

enum SelectedDrawer { Products, Orders }

class SideDrawer extends StatelessWidget {
  final SelectedDrawer posSelect;

  SideDrawer(this.posSelect);

  Widget buildMenuDrawer(String title, SelectedDrawer selected, IconData icon,
      String routeName, BuildContext ctx) {
    return InkWell(
      onTap: () {
        Navigator.of(ctx).pop();
        Navigator.pushReplacementNamed(ctx, routeName);
      },
      splashColor: Theme.of(ctx).primaryColor,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(
                color: posSelect == selected
                    ? Theme.of(ctx).primaryColor
                    : Colors.black54,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Positioned.fill(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  'Shop Apps Side',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Divider(),
          buildMenuDrawer('Products', SelectedDrawer.Products, Icons.grid_on,
              ProductsOverviewScreen.ROUTE_NAME, context),
          buildMenuDrawer('Orders', SelectedDrawer.Orders,
              Icons.shopping_basket, OrderScreen.ROUTE_NAME, context),
        ],
      ),
    );
  }
}
