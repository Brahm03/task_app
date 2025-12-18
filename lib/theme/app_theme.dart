import 'package:flutter/material.dart';
import 'package:task_wan_app/colors/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: AppColors.kPrimary,
    scaffoldBackgroundColor: AppColors.kBackgroundColor,
    fontFamily: 'NetflixSans',
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.kTextColor,
        fontFamily: "NetflixSans",
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.kTextColor,
        fontFamily: "NetflixSans",
      ),
    ),
  );
}
