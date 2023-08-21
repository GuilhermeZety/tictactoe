import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_assets.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/enums/player_type.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/modules/game/presentation/cubit/game_cubit.dart';
import 'package:tictactoe/app/ui/components/custom_checkbox.dart';
import 'package:tictactoe/app/ui/components/loader.dart';
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
                if (state is GameLoading || cubit.room == null) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Acessando sala...',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
                          ),
                          Gap(20),
                          Loader(
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.logo,
                        width: 130,
                      ).hero('logo'),
                      const Gap(50),
                      Builder(
                        builder: (context) {
                          if (cubit.room?.turn == cubit.playerType) {
                            return Text(
                              'Seu turno',
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cubit.room?.turn == PlayerType.host ? AppColors.purple_400 : AppColors.pink_400),
                            );
                          }
                          return Text(
                            'Turno do adversário',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: cubit.room?.turn == PlayerType.host ? AppColors.purple_400 : AppColors.pink_400),
                          );
                        },
                      ),
                      const Gap(20),
                      Panel(
                        child: SeparatedColumn(
                          separatorBuilder: () => const Gap(20),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${cubit.room?.victories.$1} - ${cubit.playerType == PlayerType.host ? 'Você' : 'Ele'}',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.purple_400),
                                ),
                                Text(
                                  '${cubit.room?.victories.$2} - ${cubit.playerType == PlayerType.opponent ? 'Você' : 'Ele'}',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.pink_400),
                                ),
                              ],
                            ),
                            Panel(
                              padding: const EdgeInsets.all(10),
                              color: AppColors.grey_500,
                              child: GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  9,
                                  (index) {
                                    return GestureDetector(
                                      // onTap: () => cubit.play(index),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            color: AppColors.grey_300,
                                            padding: cubit.indexPadding(index),
                                            child: Container(
                                              color: AppColors.grey_500,
                                              padding: const EdgeInsets.all(6),
                                              child: CustomCheckbox(
                                                value: cubit.room?.board[index] != 0
                                                    ? cubit.room?.board[index] == 1
                                                        ? true
                                                        : false
                                                    : null,
                                                size: constraints.maxWidth,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
