import 'package:flutter/material.dart';

import 'package:meal/models/meal.dart';
import 'package:meal/screens/meal_details.dart';
import 'package:meal/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        // Enhance: Increased size of the column content for better visual appeal
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Add a relevant icon for visual interest
          Icon(
            Icons.sentiment_dissatisfied, // Use a sad/empty state icon
            size: 80,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(height: 24), // Increased spacing
          Text(
            'Uh oh... no meals found!', // Slightly more professional text
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith( // Use headlineMedium for better hierarchy
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12), // Adjusted spacing
          Text(
            'Try selecting a different category or adjusting your filters.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        // 2. Add horizontal padding for a polished look, especially on wide screens
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          key: ValueKey(meals[index].id), // Good practice for lists
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    // 3. Conditional return: If title is present, wrap in Scaffold (for Categories screen)
    if (title != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
    }

    // 4. If title is null, return just the content (for Favorites tab)
    return content;
  }
}