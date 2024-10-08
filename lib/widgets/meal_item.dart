import 'package:flutter/material.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(
      {super.key, required this.mealModel, required this.onSelectMeal});
  final MealModel mealModel;
  final void Function(MealModel mealModel) onSelectMeal;

  String get complexityType {
    return mealModel.complexity.name[0].toUpperCase() +
        mealModel.complexity.name.substring(1);
  }

  String get affordabilityType {
    return mealModel.affordability.name[0].toUpperCase() +
        mealModel.affordability.name.substring(1);
  }

  // void testSelect(BuildContext context, MealModel meal){
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => MealsDetail(meal),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(mealModel);
          // testSelect(context, mealModel);
        },
        child: Stack(
          children: [
            Hero(
              tag: mealModel.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(mealModel.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 46),
                child: Column(
                  children: [
                    Text(
                      mealModel.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            Icons.schedule, '${mealModel.duration} min'),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.work, complexityType),
                        const SizedBox(width: 12),
                        MealItemTrait(Icons.attach_money, affordabilityType)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
