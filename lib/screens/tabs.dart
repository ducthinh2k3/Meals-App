import 'package:flutter/material.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filter_provider.dart';

const kInitFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  // final List<MealModel> _favouriteMeals = [];
  // void toggleFavourites(MealModel mealModel) {
  //   final isExisting = _favouriteMeals.contains(mealModel);
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.remove(mealModel);
  //     });
  //     showInfoMesseage('Remove favourite');
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(mealModel);
  //     });
  //     showInfoMesseage('add favourite');
  //   }
  // }

  void onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);

    Widget content = Categories(availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      content = Meals(
        null,
        favouriteMeals
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
