import 'package:flutter/material.dart';
import 'package:todo_app/data/colors/colors.dart';
import 'package:todo_app/presentation/theme/widget_themes/text_field_theme.dart';
import 'package:todo_app/presentation/theme/widget_themes/text_theme.dart';

class TodoTheme {
  TodoTheme._();

  static ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ToDoColors.primary, brightness: Brightness.light),
      useMaterial3: true,
      scaffoldBackgroundColor: ToDoColors.scaffoldLight,
      inputDecorationTheme: TextFieldTheme.textfieldLightTheme,
      textTheme: TodoTextTheme.textThemeLight,
      canvasColor: ToDoColors.containerLight);

  //----------------------------------------------------------------------------//

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: ToDoColors.primary, brightness: Brightness.dark),
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ToDoColors.scaffoldDark,
    textTheme: TodoTextTheme.textThemeDark,
    inputDecorationTheme: TextFieldTheme.textfieldDarkTheme,
    canvasColor: ToDoColors.containerDark,
  );
}
