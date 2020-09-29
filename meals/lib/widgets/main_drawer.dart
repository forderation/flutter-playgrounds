import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, Icon icon, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(10),
            child: Text(
              'Cooking Up !',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(height: 20),
          _buildListTile(
              'Meals',
              Icon(
                Icons.restaurant,
                size: 24,
              ),
              () => Navigator.of(context).pushReplacementNamed('/')),
          _buildListTile(
              'Settings',
              Icon(
                Icons.settings,
                size: 24,
              ),
              () => Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.ROUTE))
        ],
      ),
    );
  }
}
