import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_game/screens/enter_name.dart';

import '../controllers/game_controller.dart';
import '../utils/colors.dart';
import '../widgets/elevated_button_widget.dart';
import '../widgets/text_widget.dart';

class JoinGame extends StatelessWidget {
  const JoinGame({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.find<StartGameController>();

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, secondaryColor])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              text: "Join Game",
              fontSize: 40,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: gameController.gameIdController.value,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    counterText: '',
                    contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                    hintText: "Game Id",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
                child: ElevatedButtonWidget(
                    callBack: () {
                      if (gameController.gameIdController.value.text
                          .trim()
                          .isNotEmpty) {
                        Get.to(() => const EnterNameScreen(newGame: false),
                            duration: const Duration(milliseconds: 500),
                            transition: Transition.rightToLeft);
                      }
                    },
                    text: "Join")),
          ],
        ),
      ),
    );
  }
}
