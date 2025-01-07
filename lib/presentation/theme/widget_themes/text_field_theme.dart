import 'package:flutter/material.dart';
import 'package:todo_app/data/colors/colors.dart';

class TextFieldTheme {
  static InputDecorationTheme textfieldLightTheme = const InputDecorationTheme(
    fillColor: ToDoColors.textFieldLight,
  );
  static InputDecorationTheme textfieldDarkTheme = const InputDecorationTheme(
    fillColor: ToDoColors.textFieldDark,
  );
}
