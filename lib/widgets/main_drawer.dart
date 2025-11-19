import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    // Determine the color for text and icons inside the header for contrast
    final headerTextColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return Drawer(
      // 1. Set a wider width for better visual balance (optional)
      width: 280,
      child: Column(
        children: [
          // 2. Enhanced DrawerHeader
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary, // Use primary color as base
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.ramen_dining_rounded, // Use a modern, distinct icon
                  size: 40,
                  color: headerTextColor, // Use high-contrast color
                ),
                const SizedBox(width: 16),
                Text(
                  'Gourmet Guide', // Enhanced title
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith( // Use headlineSmall for bolder text
                    color: headerTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 3. ListTile for Meals
          ListTile(
            leading: Icon(
              Icons.restaurant_menu, // Use a more specific icon
              size: 28,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith( // Use titleMedium for better scaling
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22, // Keep text large
              ),
            ),
            onTap: () {
              onSelectScreen('meals');
            },
          ),

          // 4. Add a Divider for visual separation
          const Divider(indent: 16, endIndent: 16, thickness: 1),

          // 5. ListTile for Filters
          ListTile(
            leading: Icon(
              Icons.tune, // Use a specific settings icon (like a tuner/filter)
              size: 28,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
              ),
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}