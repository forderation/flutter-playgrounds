import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/products_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // NOTE: go for listen false if there is no something data to update
    // but we can split with Consumer for performance reason to data if get update

    final product = Provider.of<Product>(context, listen: false);
    final cardContainer = Provider.of<Cart>(context, listen: false);
    print("build / render widget");

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(5), bottom: Radius.circular(10)),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.ROUTE_NAME, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
              icon: Consumer<Product>(
                // NOTE: child in build used for reference child param on Consumer constructor
                builder: (ctx, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () {
                product.toggleFavorite();
              }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          trailing: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cardContainer.addItem(product.id, product.price, product.title);
              }),
        ),
      ),
    );
  }
}
