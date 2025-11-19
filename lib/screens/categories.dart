import 'package:flutter/material.dart';

import 'package:meal/data/dummy_data.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widgets/category_grid_item.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  // 1. Helper function for consistent push navigation
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 2. Use a StatefulWidget or a custom animated wrapper for a smooth fade-in
    // Since this widget is a StatelessWidget, we'll use a simpler built-in technique
    // that doesn't require state changes for the initial load.
    return GridView(
      // 3. Keep Padding and GridDelegate clean
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // Use a staggered animation effect for each item
        for (final category in availableCategories)
        // We can't easily animate a StatelessWidget's children on mount,
        // so we'll wrap the item in a simple widget for cleaner structure
          CategoryGridItem(
            // 4. Use a key to prevent Flutter from reusing the wrong widget instance
            // if the list ever changed (good practice)
            key: ValueKey(category.id),
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}

// --------------------------------------------------------------------------------
// OPTIONAL: Using a StatefulWidget to implement a proper, smooth fade-in animation
// This is generally the best way to make the categories "pop" upon loading.
// --------------------------------------------------------------------------------

class CategoriesScreenAnimated extends StatefulWidget {
  const CategoriesScreenAnimated({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreenAnimated> createState() => _CategoriesScreenAnimatedState();
}

class _CategoriesScreenAnimatedState extends State<CategoriesScreenAnimated>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // Animation goes from 0.0 (fully transparent/small) to 1.0 (fully opaque/normal size)
      lowerBound: 0,
      upperBound: 1,
    );

    // Start the animation immediately when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: widget.onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // Use the builder to wrap the GridView, applying the animation effect
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(
          // Animate the padding from top (0) to its final position (24)
          top: 100 - _animationController.value * 100,
        ),
        child: Opacity(
          // Animate the opacity from 0.0 to 1.0
          opacity: _animationController.value,
          child: child, // The GridView itself
        ),
      ),
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              key: ValueKey(category.id),
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}