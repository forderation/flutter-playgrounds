import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavoritesScreen(this.favMeals);

  void removeMeals(String mealId) {}

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
          child: Text('You have no favorites meals - adding some yet !'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          final mealData = favMeals[idx];
          return MealItem(
              id: mealData.id,
              removeItem: removeMeals,
              title: mealData.title,
              imageUrl: mealData.imageUrl,
              duration: mealData.duration,
              complexity: mealData.complexity,
              affordability: mealData.affordability);
        },
        itemCount: favMeals.length,
      );
    }
  }
}
