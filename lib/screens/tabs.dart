import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<Filter, bool> _selectedFilter = kInitFilter;

  final List<MealModel> _favouriteMeals = [];
  void showInfoMesseage(String mes) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mes),
      ),
    );
  }

  void toggleFavourites(MealModel mealModel) {
    final isExisting = _favouriteMeals.contains(mealModel);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(mealModel);
      });
      showInfoMesseage('Remove favourite');
    } else {
      setState(() {
        _favouriteMeals.add(mealModel);
      });
      showInfoMesseage('add favourite');
    }
  }

  void onSelectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(_selectedFilter ),
        ),
      );
      setState(() {
        _selectedFilter = result ?? kInitFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMealModels.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget content = Categories(toggleFavourites, availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      content = Meals(null, _favouriteMeals, toggleFavourites);
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
