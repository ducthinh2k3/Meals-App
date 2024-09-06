import 'package:flutter/material.dart';
import 'package:meals_app/model/meal_model.dart';

class MealsDetail extends StatelessWidget {
  const MealsDetail(this.mealModel, this.onToggleFavourite, {super.key});
  final MealModel mealModel;
  final void Function(MealModel mealModel) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealModel.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavourite(mealModel);
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              mealModel.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ...mealModel.ingredients.map(
              (ingredient) {
                return Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ...mealModel.steps.map(
              (ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    ingredient,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
