import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.maxLines});

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.fredoka(
          decoration: TextDecoration.none,
          fontSize: fontSize ?? 50,
          color: color ?? headingColor,
          fontWeight: fontWeight ?? FontWeight.w600,
        ));
  }
}
