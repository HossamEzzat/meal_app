import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal/screens/tabs.dart';

// Define the custom seed color for the app
const _customSeedColor = Color.fromARGB(255, 230, 99, 0); // Brighter orange/amber

final theme = ThemeData(
  // 1. Ensure Material 3 is used for modern components
  useMaterial3: true,

  // 2. Define Color Scheme: Using a brighter seed color for a warmer look
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: _customSeedColor,
  ),

  // 3. Define Typography: Using Lato for all text
  textTheme: GoogleFonts.latoTextTheme(
    // Ensure text colors work well with the dark theme
    ThemeData.dark().textTheme,
  ),

  // 4. Customizing the Scaffold background color for a slightly darker aesthetic
  scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),

  // 5. Customizing the AppBar for a seamless dark-mode look
  appBarTheme: const AppBarTheme(
    centerTitle: false, // Generally better alignment
    backgroundColor: Colors.transparent, // Transparent for a modern look
    elevation: 0, // No shadow for a flat, modern design
  ),

  // 6. Customizing Card theme (for MealItem and CategoryGridItem)
  cardTheme: CardThemeData(
    color: const Color.fromARGB(255, 30, 30, 30), // Slightly lighter background for cards
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Consistent rounding
    ),
  ),

  // 7. Customizing SwitchListTile theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _customSeedColor; // Active color
      }
      return Colors.grey; // Inactive color
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _customSeedColor.withOpacity(0.5); // Active track color
      }
      return Colors.grey.withOpacity(0.3); // Inactive track color
    }),
  ),

  // 8. Customizing BottomNavigationBar (if not overridden in TabsScreen)
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color.fromARGB(255, 30, 30, 30),
    selectedItemColor: _customSeedColor,
    unselectedItemColor: Colors.white70,
    elevation: 8,
  ),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: theme,
      home: const TabsScreen(),
    );
  }
}