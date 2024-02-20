import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_game/model/game_model.dart';
import 'package:tic_tac_toe_game/screens/home_screen.dart';
import 'package:tic_tac_toe_game/utils/colors.dart';
import 'package:tic_tac_toe_game/widgets/elevated_button_widget.dart';
import 'package:tic_tac_toe_game/widgets/text_widget.dart';
import 'package:uuid/uuid.dart';

import '../screens/game_screen.dart';

class StartGameController extends GetxController {
  var playerOneNameController = TextEditingController().obs;
  var playerTwoNameController = TextEditingController().obs;

  final firestore = FirebaseFirestore.instance.collection("tic_tac");
  final gameIdController = TextEditingController().obs;
  RxInt playerType = 1.obs;

  var gameModel = GameModel().obs;

  Future<void> startGame() async {
    final gameId = const Uuid().v4();
    gameIdController.value.text = gameId;

    firestore.doc(gameId).set({
      "gameId": gameId,
      "player1": playerOneNameController.value.text.trim(),
      "player2": "",
      "turn": 1,
      "board": List.filled(9, 0),
      "isGameOver": false
    });

    await getGameData();

    Future.delayed(const Duration(milliseconds: 200), () {
      Get.to(() => const GameScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeft);
    });
  }

  Future<void> joinGame() async {
    if (gameIdController.value.text.trim().isNotEmpty) {
      DocumentSnapshot doc =
          await firestore.doc(gameIdController.value.text.trim()).get();
      if (doc.exists) {
        if (doc["player2"] == "") {
          firestore
              .doc(gameIdController.value.text)
              .update({"player2": playerTwoNameController.value.text.trim()});
          await getGameData();

          Future.delayed(const Duration(milliseconds: 200), () {
            Get.to(() => const GameScreen(),
                duration: const Duration(milliseconds: 500),
                transition: Transition.rightToLeft);
          });
        } else {
          Fluttertoast.showToast(msg: "Player 2 already joined!");
        }
      } else {
        Fluttertoast.showToast(msg: "Incorrect game id");
      }
    }
  }

  Future getGameData() async {
    firestore
        .doc(gameIdController.value.text.trim())
        .snapshots()
        .listen((event) {
      gameModel.value = GameModel.fromFirestore(event);

      String winner = checkWinner(gameModel.value.board);
      if (winner != 'No winner yet.') {
        gameEnd();
        winDialog(winner);
      }
    });
  }

  Future restartGame() async {
    var doc = await firestore.doc(gameModel.value.gameId).get();
    if (doc.exists) {
      Get.back();
      await firestore.doc(gameModel.value.gameId).update({
        'isGameOver': false,
        'board': [0, 0, 0, 0, 0, 0, 0, 0, 0],
        'turn': 1
      });
    } else {
      Fluttertoast.showToast(msg: "Opponent leave!");
      Get.offAll(() => HomeScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.upToDown);
    }
  }

  Future updateGame() async {
    firestore
        .doc(gameModel.value.gameId)
        .update({'turn': gameModel.value.turn, 'board': gameModel.value.board});
  }

  Future gameEnd() async {
    firestore.doc(gameModel.value.gameId).update({"isGameOver": true});
  }

  Future deleteGame() async {
    firestore.doc(gameModel.value.gameId).delete();
  }

  String checkWinner(List<int>? board) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> pattern in winPatterns) {
      if (board![pattern[0]] != 0 &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return board[pattern[0]] == 1
            ? "${gameModel.value.player1} wins!"
            : "${gameModel.value.player2} wins!";
      }
    }

    if (!board!.contains(0)) {
      return 'It\'s a draw!';
    }

    return 'No winner yet.';
  }

  winDialog(String winner) {
    Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: boxColor,
        title: '',
        onWillPop: () async {
          return false;
        },
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              TextWidget(
                text: winner,
                fontSize: 24,
                maxLines: 2,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButtonWidget(
                  callBack: () {
                    Get.back();
                    gameModel.value.board = [0, 0, 0, 0, 0, 0, 0, 0, 0];
                    gameModel.value.turn = 1;
                    gameModel.value.isGameOver = false;
                    restartGame();
                  },
                  text: "Restart"),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () async {
                    await deleteGame();
                    Get.offAll(() => HomeScreen(),
                        duration: const Duration(milliseconds: 500),
                        transition: Transition.upToDown);
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith<BorderSide>(
                        (Set<MaterialState> states) {
                      return const BorderSide(color: headingColor, width: 1.5);
                    }),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(33, 3, 33, 3)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: const TextWidget(
                    text: "Home",
                    fontSize: 28,
                    color: Colors.white,
                  ))
            ],
          ),
        ));
  }
}
