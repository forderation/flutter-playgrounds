import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const ROUTE = '/categories-meals';
  final List<Meal> avalaibleMeals;

  CategoriesMealsScreen(this.avalaibleMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  Category catData;
  List<Meal> diplayedMeals;
  var didInitState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // NOTE: didChangeDependencies run where state on initState is called, it means run after it
    if (!didInitState) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      catData = routeArgs['catData'] as Category;
      diplayedMeals = widget.avalaibleMeals
          .where((element) => element.categories.contains(catData.id))
          .toList();
      didInitState = true;
    }
    super.didChangeDependencies();
  }

  void removeMeals(String mealId) {
    setState(() {
      diplayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(catData.title),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, idx) {
            final mealData = diplayedMeals[idx];
            return MealItem(
                id: mealData.id,
                removeItem: removeMeals,
                title: mealData.title,
                imageUrl: mealData.imageUrl,
                duration: mealData.duration,
                complexity: mealData.complexity,
                affordability: mealData.affordability);
          },
          itemCount: diplayedMeals.length,
        ));
  }
}
