import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_game/controllers/game_controller.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/text_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameController = Get.find<StartGameController>();

    return PopScope(
      onPopInvoked: (didPop) {
        gameController.deleteGame();
      },
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              Obx(
                () => gameController.gameModel.value.player2!.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: gameController.gameModel.value.gameId!,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                      text: gameController
                                          .gameIdController.value.text))
                                  .then((value) {
                                Fluttertoast.showToast(msg: "Game id copied");
                              });
                            },
                            icon: const Icon(
                              Icons.copy_outlined,
                              size: 26,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    : Container(),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            border: gameController.gameModel.value.turn == 1
                                ? Border.all(color: headingColor)
                                : null,
                            color: boxColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            const Center(
                              child: Icon(
                                Icons.close_rounded,
                                color: headingColor,
                                size: 60,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, left: 10),
                              child: TextWidget(
                                text: gameController.gameModel.value.player1!,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            border: gameController.gameModel.value.turn == 2
                                ? Border.all(color: headingColor)
                                : null,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            const Center(
                              child: Icon(
                                Icons.circle_outlined,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8, left: 10),
                              child: TextWidget(
                                text: gameController.gameModel.value.player2!,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                  child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (gameController.gameModel.value.player2 != "") {
                        if (gameController.gameModel.value.turn == 1) {
                          if (gameController.playerType.value == 1) {
                            if (gameController.gameModel.value.board![index] ==
                                0) {
                              gameController.gameModel.value.board![index] = 1;
                              gameController.gameModel.value.turn = 2;
                              gameController.updateGame();
                            }
                          }
                        } else {
                          if (gameController.playerType.value == 2) {
                            if (gameController.gameModel.value.board![index] ==
                                0) {
                              gameController.gameModel.value.board![index] = 2;
                              gameController.gameModel.value.turn = 1;
                              gameController.updateGame();
                            }
                          }
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Player 2 not joined yet!");
                      }
                    },
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: gameController.gameModel.value.board![index] == 0
                            ? null
                            : Center(
                                child: Icon(
                                  gameController
                                              .gameModel.value.board![index] ==
                                          1
                                      ? Icons.close_rounded
                                      : Icons.circle_outlined,
                                  color: gameController
                                              .gameModel.value.board![index] ==
                                          1
                                      ? headingColor
                                      : Colors.white,
                                  size: 80,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
