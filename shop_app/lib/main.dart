import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_products_screen.dart';
import 'screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/products.dart';
import './screens/products_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // NOTE:
    // use ChangeNotifierProvider.value (value: YourProviders, ...) if doesn't depent on context
    // If you do that to provide that object to the change notify our provider you should use the Create method
    // using create if REINSTANCE OF CHILD OBJECT is RECOMMENDED
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (cx) => Products(null, null, []),
            update: (cx, auth, products) =>
                Products(auth.token, auth.userId, products.items),
          ),
          ChangeNotifierProvider(
            create: (cx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (cx) => Orders(null, null, []),
            update: (cx, auth, orders) =>
                Orders(auth.token, auth.userId, orders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  accentColor: Colors.deepOrange,
                  primarySwatch: Colors.purple,
                  fontFamily: 'Lato',
                  textTheme:
                      TextTheme(headline4: TextStyle(color: Colors.purple))),
              home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
              routes: {
                ProductsOverviewScreen.ROUTE_NAME: (ctx) =>
                    ProductsOverviewScreen(),
                ProductDetail.ROUTE_NAME: (ctx) => ProductDetail(),
                CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
                OrderScreen.ROUTE_NAME: (ctx) => OrderScreen(),
                UserProductsScreen.ROUTE_NAME: (ctx) => UserProductsScreen(),
                EditProductsScrenn.ROUTE_NAME: (ctx) => EditProductsScrenn()
              },
            );
          },
        ));
  }
}
