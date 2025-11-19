import 'package:flutter/material.dart';

import 'package:meal/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
    // ASSUME: The parent widget (TabsScreen) is updated to pass the favorite status
    this.isFavorite = false,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;
  final bool isFavorite; // New property to determine icon state

  @override
  Widget build(BuildContext context) {
    // Determine the color of the primary text elements (Ingredients/Steps headers)
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          // 1. Favorite Icon State Enhancement
          IconButton(
            onPressed: () {
              onToggleFavorite(meal);
            },
            icon: AnimatedSwitcher( // Use AnimatedSwitcher for a fun "pop" effect
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              // Display the appropriate icon based on the isFavorite property
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite), // Key is essential for AnimatedSwitcher
                color: isFavorite ? Theme.of(context).colorScheme.tertiary : null,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Image with Hero Animation for smoother transition
            Hero(
              tag: meal.id, // Must be unique; using meal ID
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // --- Ingredients Section ---
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 3. Structured List for Ingredients (using Container for visual focus)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final ingredient in meal.ingredients)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '• $ingredient', // Use a bullet point for clarity
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- Steps Section ---
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 4. Structured List for Steps (using Padding/ListTile style)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (var i = 0; i < meal.steps.length; i++)
                    ListTile(
                      // Use index for step number
                      leading: CircleAvatar(
                        backgroundColor: color,
                        child: Text(
                          (i + 1).toString(),
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      title: Text(
                        meal.steps[i],
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30), // Extra space at the bottom
          ],
        ),
      ),
    );
  }
}