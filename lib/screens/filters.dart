import 'package:flutter/material.dart';



enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    // 1. Remove WillPopScope and rely on the AppBar's back button
    // The filter data will be returned in the build method's Scaffold,
    // which simplifies the screen logic.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Filters'), // Enhanced title
      ),
      // 2. Return the filter map when the screen is disposed (when back button is pressed)
      // This is a cleaner way to handle data return from a screen.
      body: Column(
        children: [
          // 3. Informative Header Text
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              'Adjust your meal selection using the toggles below.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(height: 30, thickness: 1.5, indent: 20, endIndent: 20),

          // 4. Use Theme colors for better integration
          Expanded( // Wrap the list in Expanded to ensure it fills the available space
            child: ListView(
              children: [
                _buildFilterSwitch(
                  context,
                  title: 'Gluten-free',
                  subtitle: 'Only include meals that are gluten-free.',
                  value: _glutenFreeFilterSet,
                  onChanged: (isChecked) {
                    setState(() {
                      _glutenFreeFilterSet = isChecked;
                    });
                  },
                ),
                _buildFilterSwitch(
                  context,
                  title: 'Lactose-free',
                  subtitle: 'Only include meals that are lactose-free.',
                  value: _lactoseFreeFilterSet,
                  onChanged: (isChecked) {
                    setState(() {
                      _lactoseFreeFilterSet = isChecked;
                    });
                  },
                ),
                _buildFilterSwitch(
                  context,
                  title: 'Vegetarian',
                  subtitle: 'Only include vegetarian meals.',
                  value: _vegetarianFilterSet,
                  onChanged: (isChecked) {
                    setState(() {
                      _vegetarianFilterSet = isChecked;
                    });
                  },
                ),
                _buildFilterSwitch(
                  context,
                  title: 'Vegan',
                  subtitle: 'Only include strictly vegan meals.',
                  value: _veganFilterSet,
                  onChanged: (isChecked) {
                    setState(() {
                      _veganFilterSet = isChecked;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a clean SwitchListTile
  Widget _buildFilterSwitch(
      BuildContext context, {
        required String title,
        required String subtitle,
        required bool value,
        required void Function(bool) onChanged,
      }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary, // Use tertiary for accent
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8), // Adjusted padding
    );
  }


}

// --------------------------------------------------------------------------------
// Final Code using the WillPopScope logic (for compatibility with your original logic)
// --------------------------------------------------------------------------------

class FiltersScreenFinal extends StatefulWidget {
  const FiltersScreenFinal({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreenFinal> createState() => _FiltersScreenStateFinal();
}

class _FiltersScreenStateFinal extends State<FiltersScreenFinal> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Filters'),
        // No actions needed, relying on WillPopScope for data return
      ),
      // 5. WillPopScope is used to return the Map when the back button is pressed.
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return false; // Prevent the default back navigation
        },
        child: Column(
          children: [
            // Informative Header Text
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Adjust your meal selection using the toggles below.',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 30, thickness: 1.5, indent: 20, endIndent: 20),

            // Filters List
            Expanded(
              child: ListView(
                children: [
                  _buildFilterSwitch(
                    context,
                    title: 'Gluten-free',
                    subtitle: 'Only include meals that are gluten-free.',
                    value: _glutenFreeFilterSet,
                    onChanged: (isChecked) {
                      setState(() {
                        _glutenFreeFilterSet = isChecked;
                      });
                    },
                  ),
                  _buildFilterSwitch(
                    context,
                    title: 'Lactose-free',
                    subtitle: 'Only include meals that are lactose-free.',
                    value: _lactoseFreeFilterSet,
                    onChanged: (isChecked) {
                      setState(() {
                        _lactoseFreeFilterSet = isChecked;
                      });
                    },
                  ),
                  _buildFilterSwitch(
                    context,
                    title: 'Vegetarian',
                    subtitle: 'Only include vegetarian meals.',
                    value: _vegetarianFilterSet,
                    onChanged: (isChecked) {
                      setState(() {
                        _vegetarianFilterSet = isChecked;
                      });
                    },
                  ),
                  _buildFilterSwitch(
                    context,
                    title: 'Vegan',
                    subtitle: 'Only include strictly vegan meals.',
                    value: _veganFilterSet,
                    onChanged: (isChecked) {
                      setState(() {
                        _veganFilterSet = isChecked;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for clean SwitchListTile definition
  Widget _buildFilterSwitch(
      BuildContext context, {
        required String title,
        required String subtitle,
        required bool value,
        required void Function(bool) onChanged,
      }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
    );
  }
}