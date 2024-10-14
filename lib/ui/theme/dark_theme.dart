import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xFFF4AA7E),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFF4AA7E),
    surface: const Color(0xFF121212),
    brightness: Brightness.dark,
  ),
  cardColor: const Color(0xFF252525),
  scaffoldBackgroundColor: const Color(0xFF121212),
  splashFactory: InkRipple.splashFactory,
  hintColor: const Color(0xFF7b7b7b),
  canvasColor: const Color(0xFF252525),
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      fontSize: 16,
      overflow: TextOverflow.ellipsis,
      color: Color(0xFF7b7b7b),
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
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
      color: Colors.white60,
      overflow: TextOverflow.ellipsis,
    ),
    bodySmall: TextStyle(
      color: Colors.white38,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
