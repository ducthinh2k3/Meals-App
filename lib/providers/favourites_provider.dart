import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal_model.dart';

class FavouritesMealsNotifier extends StateNotifier<List<MealModel>> {
  FavouritesMealsNotifier() : super([]);

  bool toggleFavourites(MealModel mealModel) {
    final isExisting = state.contains(mealModel);
    if (isExisting) {
      state = state.where((meal) => meal.id != mealModel.id).toList();
      return false;
    } else {
      state = [...state, mealModel];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouritesMealsNotifier, List<MealModel>>((ref) {
  return FavouritesMealsNotifier();
});
