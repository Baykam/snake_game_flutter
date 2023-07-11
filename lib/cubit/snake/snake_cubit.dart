import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'snake_state.dart';

enum SnakeDirections { up, down, left, right }

class SnakeCubit extends Cubit<SnakeState> {
  SnakeCubit(BuildContext context)
      : super(SnakeState(
            snakePosition: const [0, 1, 2],
            currentDirection: SnakeDirections.right,
            foodPosition: 55,
            gameHasStarted: false,
            currentScore: 0,
            rowSize: 10,
            totalNumberSquare: 100,
            scaffoldContext: context));

  void startGame() {
    emit(state.copyWith(gameHasStarted: true));

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      moveSnake();

      if (gameOver()) {
        timer.cancel();
        showDialog(
          context: state.scaffoldContext,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Column(
                children: [
                  Text('Your Score is: ${state.currentScore}'),
                  const TextField(
                    decoration: InputDecoration(hintText: 'Enter name'),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    submitScore();
                    Navigator.pop(dialogContext);
                    newGame();
                  },
                  color: Colors.pink,
                  child: const Text('Submit'),
                )
              ],
            );
          },
        );
      }
    });
  }

  void newGame() {
    emit(state.copyWith(
      snakePosition: [0, 1, 2],
      currentDirection: SnakeDirections.right,
      foodPosition: 55,
      gameHasStarted: false,
      currentScore: 0,
    ));
  }

  void submitScore() {
    // add data to firebase
  }

  void eatFood() {
    emit(state.copyWith(
      currentScore: state.currentScore + 1,
      foodPosition: Random().nextInt(state.totalNumberSquare),
    ));
  }

  bool gameOver() {
    List<int> bodySnake =
        state.snakePosition.sublist(0, state.snakePosition.length - 1);
    return bodySnake.contains(state.snakePosition.last);
  }

  void moveSnake() {
    final currentDirection = state.currentDirection;
    final snakePosition = state.snakePosition.toList();
    final foodPosition = state.foodPosition;

    switch (currentDirection) {
      case SnakeDirections.right:
        if (snakePosition.last % state.rowSize == 9) {
          snakePosition.add(snakePosition.last + 1 - state.rowSize);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }

        break;
      case SnakeDirections.left:
        if (snakePosition.last % state.rowSize == 0) {
          snakePosition.add(snakePosition.last - 1 + state.rowSize);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }
        break;
      case SnakeDirections.down:
        if (snakePosition.last + state.rowSize > state.totalNumberSquare) {
          snakePosition.add(
              snakePosition.last + state.rowSize - state.totalNumberSquare);
        } else {
          snakePosition.add(snakePosition.last + state.rowSize);
        }
        break;
      case SnakeDirections.up:
        if (snakePosition.last < state.rowSize) {
          snakePosition.add(
              snakePosition.last - state.rowSize + state.totalNumberSquare);
        } else {
          snakePosition.add(snakePosition.last - state.rowSize);
        }
        break;
      default:
    }

    if (snakePosition.last == foodPosition) {
      eatFood();
    } else {
      snakePosition.removeAt(0);
    }

    emit(state.copyWith(snakePosition: snakePosition));
  }

  void changeDirection(SnakeDirections newDirection) {
    emit(state.copyWith(currentDirection: newDirection));
  }
}
