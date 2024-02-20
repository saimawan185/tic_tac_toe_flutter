import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_game/controllers/game_controller.dart';
import 'package:tic_tac_toe_game/model/game_model.dart';
import 'package:tic_tac_toe_game/screens/enter_name.dart';
import 'package:tic_tac_toe_game/screens/join_game.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/elevated_button_widget.dart';
import 'package:tic_tac_toe_game/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final startGameController = Get.put(StartGameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, secondaryColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextWidget(text: "Tik Tac Toe"),
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close_rounded,
                  color: headingColor,
                  size: 125,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                  size: 100,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButtonWidget(
                callBack: () {
                  startGameController.gameIdController.value.clear();
                  startGameController.playerOneNameController.value.clear();
                  startGameController.playerTwoNameController.value.clear();
                  startGameController.playerType.value = 1;
                  startGameController.gameModel.value = GameModel();
                  Get.to(() => const EnterNameScreen(newGame: true),
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.rightToLeft);
                },
                text: "New Game"),
            const SizedBox(height: 30),
            OutlinedButton(
                onPressed: () {
                  startGameController.gameIdController.value.clear();
                  startGameController.playerOneNameController.value.clear();
                  startGameController.playerTwoNameController.value.clear();
                  startGameController.gameModel.value = GameModel();
                  startGameController.playerType.value = 2;
                  Get.to(() => const JoinGame(),
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.rightToLeft);
                },
                style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                    return const BorderSide(color: headingColor, width: 1.5);
                  }),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(30, 3, 30, 3)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: const TextWidget(
                  text: "Join Game",
                  fontSize: 28,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
