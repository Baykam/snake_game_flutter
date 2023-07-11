import 'package:all_functions/widgets/blank_pixel.dart';
import 'package:all_functions/widgets/food_pixel.dart';
import 'package:all_functions/widgets/snake_pixel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'cubit/snake/snake_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SnakeCubit, SnakeState>(
      builder: (context, state) => Scaffold(
        body: Column(children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Current Score'),
                    BlocBuilder<SnakeCubit, SnakeState>(
                      builder: (context, state) {
                        return Text(state.currentScore.toString());
                      },
                    ),
                  ],
                ),
                const Text('highScores...'),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  BlocProvider.of<SnakeCubit>(context)
                      .changeDirection(SnakeDirections.down);
                }
                if (details.delta.dy < 0) {
                  BlocProvider.of<SnakeCubit>(context)
                      .changeDirection(SnakeDirections.up);
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  BlocProvider.of<SnakeCubit>(context)
                      .changeDirection(SnakeDirections.right);
                }
                if (details.delta.dx < 0) {
                  BlocProvider.of<SnakeCubit>(context)
                      .changeDirection(SnakeDirections.left);
                }
              },
              child: GridView.builder(
                itemCount: state.totalNumberSquare,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: state.rowSize,
                ),
                itemBuilder: (context, index) {
                  return BlocBuilder<SnakeCubit, SnakeState>(
                    builder: (context, state) {
                      if (state.snakePosition.contains(index)) {
                        return const SnakePixel();
                      } else if (state.foodPosition == index) {
                        return const FoodPixel();
                      } else {
                        return const BlankPixel();
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: BlocBuilder<SnakeCubit, SnakeState>(
                builder: (context, state) {
                  return MaterialButton(
                    onPressed: state.gameHasStarted
                        ? () {}
                        : () {
                            context.read<SnakeCubit>().startGame();
                          },
                    color: state.gameHasStarted ? Colors.grey : Colors.pink,
                    child: const Text('PLAY'),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
