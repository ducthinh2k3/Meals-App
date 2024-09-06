import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category_model.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class Categories extends StatelessWidget {
  const Categories(this.availableMeals, {super.key});
  final List<MealModel> availableMeals;

  void _selectCategory(BuildContext context, Categorymodel category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Meals(
          category.title,
          filteredMeals
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 30,
      ),
      children: availableCategories.map(
        (category) {
          return CategoryGridItem(category, () {
            _selectCategory(context, category);
          });
        },
      ).toList(),
    );
  }
}
