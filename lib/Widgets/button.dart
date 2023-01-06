import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String text;
  Color textColor;
  Color backgroundColor;

  Button({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 45,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: textColor),
        ),
      ),
    );
  }
}
