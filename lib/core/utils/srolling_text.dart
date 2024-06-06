import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class ScrollingText extends StatelessWidget {
  final String text;
  final int limit;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const ScrollingText(
      this.text,
      this.limit, {super.key,
        this.fontSize = 12.0,
        this.color,
        this.fontWeight,
      });

  @override
  Widget build(BuildContext context) {
    if (text.length > limit) {
      return TextScroll(
        text,
        velocity: const Velocity(pixelsPerSecond: Offset(5, 0)),
        intervalSpaces: 2,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          // Ajoute d'autres styles si nécessaire
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          // Ajoute d'autres styles si nécessaire
        ),
      );
    }
  }
}
