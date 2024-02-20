import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_game/controllers/game_controller.dart';
import 'package:tic_tac_toe_game/widgets/elevated_button_widget.dart';
import '../utils/colors.dart';
import '../widgets/text_widget.dart';

class EnterNameScreen extends StatelessWidget {
  const EnterNameScreen({super.key, required this.newGame});

  final bool newGame;

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: "Enter Your Name",
              fontSize: 35,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  newGame ? Icons.close_rounded : Icons.circle_outlined,
                  color: newGame ? headingColor : Colors.white,
                  size: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                TextWidget(
                  text: newGame ? "Player 1" : "Player 2",
                  fontSize: 28,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: newGame
                    ? gameController.playerOneNameController.value
                    : gameController.playerTwoNameController.value,
                textCapitalization: TextCapitalization.words,
                maxLength: 50,
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    counterText: '',
                    contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const SizedBox(height: 80),
            Center(
                child: ElevatedButtonWidget(
                    callBack: () async {
                      if (newGame) {
                        if (gameController
                            .playerOneNameController.value.text.isNotEmpty) {
                          await gameController.startGame();
                        }
                      } else {
                        if (gameController
                            .playerTwoNameController.value.text.isNotEmpty) {
                          await gameController.joinGame();
                        }
                      }
                    },
                    text: "Start Game")),
          ],
        ),
      ),
    );
  }
}
