import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width - 80,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.02),
          blurRadius: 3,
          spreadRadius: 0,
          offset: Offset(
            0,
            1,
          ),
        ),
        BoxShadow(
          color: Color.fromRGBO(27, 31, 35, 0.15),
          blurRadius: 0,
          spreadRadius: 1,
          offset: Offset(
            0,
            0,
          ),
        ),
      ]),
      child: TextField(
        controller: controller,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
