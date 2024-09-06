import 'package:flutter/material.dart';
import 'package:meals_app/model/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(this.categoryModel, this.onSelectCategory, {super.key});
  final Categorymodel categoryModel;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              categoryModel.color.withOpacity(0.55),
              categoryModel.color.withOpacity(0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Text(
          categoryModel.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
        ),
      ),
    );
  }
}
