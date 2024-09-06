import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
}

class FilterProvider extends StateNotifier<Map<Filter, bool>> {
  FilterProvider()
      : super(
          {
            Filter.glutenFree: false,
            Filter.lactoseFree: false,
            Filter.vegetarian: false,
          },
        );

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filterProvider = StateNotifierProvider<FilterProvider, Map<Filter, bool>>(
  (ref) {
    return FilterProvider();
  },
);

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilter = ref.watch(filterProvider);
  return meals.where((meal) {
      if (selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      } 
      if (selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
});
