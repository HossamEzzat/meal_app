import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // 1. Determine a high-contrast text color based on the overall theme's brightness
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    // Choose white or black based on the theme for optimal contrast on the colored card
    final contrastTextColor = isDarkTheme ? Colors.white : Colors.black;

    // 2. Use a Card for subtle elevation and shadow effect
    return Card(
      // Elevation gives the card a shadow and lifts it visually
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero, // Remove default card margin to utilize InkWell's tap area fully

      child: InkWell(
        onTap: onSelectCategory,
        // 3. Use the category's color, but slightly lighter, for a thematic splash
        splashColor: category.color.withOpacity(0.4),
        highlightColor: category.color.withOpacity(0.2), // Provide visual feedback on press
        borderRadius: BorderRadius.circular(16),

        child: Container(
          // Ensure container uses the same rounded shape
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.6), // Slightly adjusted opacity
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              // 4. Use the calculated contrast color
              color: contrastTextColor,
              fontWeight: FontWeight.bold, // Make the title stand out more
            ),
          ),
        ),
      ),
    );
  }
}