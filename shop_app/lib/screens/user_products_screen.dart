import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_products_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/user-products';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: SideDrawer(SelectedDrawer.ManageProducts),
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductsScrenn.ROUTE_NAME))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.separated(
            itemBuilder: (_, i) => UserProductItem(productsData.items[i].id,
                productsData.items[i].title, productsData.items[i].imageUrl),
            itemCount: productsData.items.length,
            separatorBuilder: (_, i) => Divider(),
          ),
        ),
      ),
    );
  }
}
