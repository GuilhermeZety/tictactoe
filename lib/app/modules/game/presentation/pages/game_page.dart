import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/modules/game/presentation/cubit/game_cubit.dart';
import 'package:tictactoe/app/ui/components/panel.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.roomID});

  final int roomID;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameCubit cubit = GameCubit();
  @override
  void initState() {
    cubit.init(widget.roomID);
    super.initState();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ScaffoldGradientBackground(
        gradient: AppColors.backgrondGradient,
        // appBar:
        body: SafeArea(
          child: Center(
            child: BlocConsumer<GameCubit, GameState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is GameExit) {
                  Modular.to.pop();
                }
              },
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Panel(
                        child: SeparatedColumn(
                          separatorBuilder: () => const Gap(20),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(cubit.room?.id.toString() ?? ''),
                          ],
                        ),
                      ).hero('panel'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
