import 'package:flutter/material.dart';
import 'package:flutter_meals/data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const RouteName = "/meal-detail";

  Widget buildSectionTitle(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "$title",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 220,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          //image
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          //title Ingredients
          buildSectionTitle("Ingredients", context),
          //list Ingredients
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: theme.accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                );
              },
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          //title steps
          buildSectionTitle("Steps", context),
          //list steps
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("# ${index + 1}"),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Divider()
                ],
              );
            },
            itemCount: selectedMeal.steps.length,
          )),
        ]),
      ),
    );
  }
}
