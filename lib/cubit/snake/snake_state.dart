part of 'snake_cubit.dart';

class SnakeState extends Equatable {
  final int rowSize;
  final int totalNumberSquare;
  final bool gameHasStarted;
  final int currentScore;
  final List<int> snakePosition;
  final SnakeDirections currentDirection;
  final int foodPosition;
  final BuildContext scaffoldContext;

  const SnakeState({
    required this.rowSize,
    required this.totalNumberSquare,
    required this.gameHasStarted,
    required this.currentScore,
    required this.snakePosition,
    required this.currentDirection,
    required this.foodPosition,
    required this.scaffoldContext,
  });

  SnakeState copyWith({
    int? rowSize,
    int? totalNumberSquare,
    bool? gameHasStarted,
    int? currentScore,
    List<int>? snakePosition,
    SnakeDirections? currentDirection,
    int? foodPosition,
    BuildContext? scaffoldContext,
  }) {
    return SnakeState(
      rowSize: rowSize ?? this.rowSize,
      totalNumberSquare: totalNumberSquare ?? this.totalNumberSquare,
      gameHasStarted: gameHasStarted ?? this.gameHasStarted,
      currentScore: currentScore ?? this.currentScore,
      snakePosition: snakePosition ?? this.snakePosition,
      currentDirection: currentDirection ?? this.currentDirection,
      foodPosition: foodPosition ?? this.foodPosition,
      scaffoldContext: scaffoldContext ?? this.scaffoldContext,
    );
  }

  @override
  List<Object?> get props => [
        rowSize,
        totalNumberSquare,
        gameHasStarted,
        currentScore,
        snakePosition,
        currentDirection,
        foodPosition,
        scaffoldContext,
      ];
}
