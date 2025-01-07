import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 25,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\"The memories is a shield and life helper.\"",
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tamim Al-Barghouti",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
