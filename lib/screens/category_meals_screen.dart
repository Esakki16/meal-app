import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArg['title'] as String;
    final categoryId = routeArg['id'];
    displayedMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(categoryId),
        )
        .toList();
    super.didChangeDependencies();
  }

  void _removalMeal(String mealId) {
    setState(() {
      displayedMeals?..removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: displayedMeals![index].id,
                title: displayedMeals![index].title,
                imageUrl: displayedMeals![index].imageUrl,
                duration: displayedMeals![index].duration,
                complexity: displayedMeals![index].complexity,
                affordability: displayedMeals![index].affordability,
              );
            },
            itemCount: displayedMeals!.length));
  }
}
