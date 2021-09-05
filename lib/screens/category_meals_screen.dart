import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy_data.dart';
import 'package:flutter_meals/models/meal.dart';
import 'package:flutter_meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const RouteName = '/category-meals';

  /*final String _categoryId;
  final String _categoryTitle;

  CategoryMealsScreen(this._categoryId, this._categoryTitle);*/
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals.length == 0
          ? Center(
              child: Text("Item not found"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                Meal meal = categoryMeals[index];
                return MealItem(
                    id: meal.id,
                    title: meal.title,
                    imageUrl: meal.imageUrl,
                    duration: meal.duration,
                    complexity: meal.complexity,
                    affordability: meal.affordability);
              },
              itemCount: categoryMeals.length,
            ),
    );
  }
}
