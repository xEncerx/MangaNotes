import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Color(0xFFF4AA7E),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFF4AA7E),
    surface: const Color(0xFFfefefe),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFfefefe),
  splashFactory: InkRipple.splashFactory,
  hintColor: const Color(0xFF959494),
  canvasColor: const Color(0xFFE8E8E8),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      fontSize: 16,
      overflow: TextOverflow.ellipsis,
      color: const Color(0xFF7b7b7b),
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      overflow: TextOverflow.ellipsis,
    ),
    bodyMedium: TextStyle(
      color: const Color(0xFF7d7d7d),
      overflow: TextOverflow.ellipsis,
    ),
    bodySmall: TextStyle(
      color: Colors.grey,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
