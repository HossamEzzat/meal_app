import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';
import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  // Helper method for capitalization (remains the same)
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // 1. Wrap in a ClipRRect for cleaner edge handling, ensuring InkWell ripple respects the border
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // Increased border radius
      child: Card(
        margin: const EdgeInsets.all(10), // Increased margin for better spacing
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Must match ClipRRect
        ),
        clipBehavior: Clip.hardEdge,
        elevation: 4, // Increased elevation for a 'lifted' look
        child: InkWell(
          onTap: () {
            onSelectMeal(meal);
          },
          // 2. Use the primary color for a vibrant splash/highlight effect
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),

          child: Stack(
            children: [
              // 3. Enhanced Image Loading with Color Placeholder
              Hero(
                tag: meal.id, // For the transition to MealDetailsScreen
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  // Use a themed color as a background fallback while image loads
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  placeholderFit: BoxFit.cover, // Ensure the placeholder fills the space
                  // Optional: Show a CircularProgressIndicator while loading
                  imageErrorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: Icon(Icons.broken_image,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // 4. Slightly less opaque overlay and theme integration
                  color: Colors.black.withOpacity(0.7),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Reduced horizontal padding
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle( // 5. Use Theme for text style, ensuring high contrast
                            fontSize: 22, // Slightly larger font
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            // Optional: Add a subtle shadow to ensure text pops over image details
                            shadows: [
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.8),
                              )
                            ]
                        ),
                      ),
                      const SizedBox(height: 8), // Reduced spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min',
                          ),
                          const SizedBox(width: 10), // Reduced spacing
                          MealItemTrait(
                            icon: Icons.work,
                            label: complexityText,
                          ),
                          const SizedBox(width: 10),
                          MealItemTrait(
                            icon: Icons.attach_money,
                            label: affordabilityText,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Ensure your MealItemTrait widget is updated to accept themed colors if needed.
// For example, its icon and text should use a contrasting color like Colors.white
// for maximum readability on the dark overlay.