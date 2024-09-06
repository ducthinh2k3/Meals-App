import 'package:flutter/material.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/screens/meals_detail.dart';
import 'package:meals_app/widgets/meal_item.dart';

class Meals extends StatelessWidget {
  const Meals(this.title, this.meals, this.onToggleFavourite, {super.key});
  final String? title;
  final List<MealModel> meals;
  final void Function(MealModel mealModel) onToggleFavourite;

  void selectMeal(BuildContext context, MealModel mealModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsDetail(mealModel, onToggleFavourite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (context, index) => Text(
        meals[index].title,
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            )
          ],
        ),
      );
    }

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          mealModel: meals[index],
          onSelectMeal: (mealModel) {
            selectMeal(context, mealModel);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
