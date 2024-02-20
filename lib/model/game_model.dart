import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  final String? gameId;
  final String? player1;
  final String? player2;
  List<int>? board;
  int? turn;
  bool? isGameOver;

  GameModel(
      {this.gameId,
      this.player1,
      this.player2,
      this.board,
      this.turn,
      this.isGameOver});

  factory GameModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return GameModel(
        gameId: data['gameId'],
        player1: data['player1'],
        player2: data['player2'],
        board: List.from(data['board']),
        turn: data['turn'],
        isGameOver: data['isGameOver']);
  }

  Map<String, dynamic> toMap() {
    return {
      'gameId': gameId,
      'player1': player1,
      'player2': player2,
      'board': board,
      'turn': turn,
      'isGameOver': isGameOver
    };
  }
}
