import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Slightly larger icon size for better visibility
        Icon(
          icon,
          size: 18,
          // 2. Use a themed color if not on a dark background (though
          //    the parent MealItem uses a dark overlay, using Colors.white is correct)
          color: Colors.white,
        ),
        const SizedBox(width: 4), // 3. Reduced spacing for a more compact look
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            // 4. Use a specific theme style and ensure color remains white
            color: Colors.white,
            fontWeight: FontWeight.w500, // Make the text slightly thicker
          ),
        ),
      ],
    );
  }
}