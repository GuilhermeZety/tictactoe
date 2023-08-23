import 'dart:ui';

import 'package:confetti/confetti.dart';
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
import 'package:tictactoe/app/core/common/extensions/context_extension.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/modules/game/presentation/cubit/game_cubit.dart';
import 'package:tictactoe/app/ui/components/button.dart';
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
  ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 2));

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
                if (state is GameWin) {
                  if (state.playerType == cubit.playerType) {
                    // // WIN
                    confettiController.play();
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: context.heightPx * 0.2),
                            child: ConfettiWidget(
                              confettiController: confettiController,
                              blastDirectionality: BlastDirectionality.explosive,
                              shouldLoop: false,
                              gravity: 0.1,
                              blastDirection: 0,
                              maxBlastForce: 40,
                              minBlastForce: 20,
                              emissionFrequency: 0.1,
                              numberOfParticles: 20,
                            ),
                          ),
                        ),
                        //BLUR LAYER
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'VOCE GANHOU!!!',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green_400,
                                ),
                              ),
                              const Gap(50),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Panel(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _scoreboard,
                                      const Gap(30),
                                      const Text('Clique para jogarem uma nova partida:'),
                                      const Gap(10),
                                      Button(
                                        onPressed: () async {},
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: AppColors.grey_200,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                            const Text(
                                              'Começar outro',
                                              textAlign: TextAlign.center,
                                            ).expanded(),
                                            const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: AppColors.grey_200,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).expandedH(),
                                      const Gap(30),
                                      const Text('Clique para voltar para tela inicial:'),
                                      const Gap(10),
                                      Button.secondary(
                                        onPressed: () async {},
                                        child: const Text('Sair'),
                                      ).expandedH(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  //LOOSE
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ColoredBox(
                          color: AppColors.red_600.withOpacity(0.1),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'VOCE PERDEU',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red_400,
                              ),
                            ),
                            const Gap(50),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Panel(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _scoreboard,
                                    const Gap(30),
                                    const Text('Clique para jogarem uma nova partida:'),
                                    const Gap(10),
                                    Button(
                                      onPressed: () async {},
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColors.grey_200,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                          const Text(
                                            'Começar outro',
                                            textAlign: TextAlign.center,
                                          ).expanded(),
                                          const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColors.grey_200,
                                              strokeWidth: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).expandedH(),
                                    const Gap(30),
                                    const Text('Clique para voltar para tela inicial:'),
                                    const Gap(10),
                                    Button.secondary(
                                      onPressed: () async {},
                                      child: const Text('Sair'),
                                    ).expandedH(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                            _scoreboard,
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
                                                onSelect: () => cubit.select(index),
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

  Widget get _scoreboard => Row(
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
      );
}
