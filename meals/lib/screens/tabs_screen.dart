import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;

  TabsScreen(this.favMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {'pages': CategoriesScreen(), 'title': 'Categories'},
      {'pages': FavoritesScreen(widget.favMeals), 'title': 'Favorites'}
    ];
    super.initState();
  }

  void _selectWidget(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // default start by tabBar
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedIndex]['pages'] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.white60,
            selectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.category),
                  title: Text('Categories')),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.favorite),
                  title: Text('Favorites'))
            ],
            onTap: _selectWidget,
            currentIndex: _selectedIndex,
          ),
        ));
  }
}
