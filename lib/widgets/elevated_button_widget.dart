import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';

import 'text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, required this.callBack, required this.text});

  final Function() callBack;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callBack,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(30, 3, 30, 3)),
          backgroundColor: MaterialStateProperty.all<Color>(headingColor),
        ),
        child: TextWidget(
          text: text,
          fontSize: 28,
          color: Colors.black,
        ));
  }
}
