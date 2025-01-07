import 'package:flutter/material.dart';
import 'package:todo_app/data/colors/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size.width - 80,
        color: ToDoColors.button,
        height: 50,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
