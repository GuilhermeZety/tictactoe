import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:tictactoe/app/core/common/constants/app_assets.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/extensions/context_extension.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/ui/components/button.dart';
import 'package:tictactoe/app/ui/components/input.dart';
import 'package:tictactoe/app/ui/components/loader.dart';
import 'package:tictactoe/app/ui/components/panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _centerController;
  @override
  void initState() {
    super.initState();
    _centerController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Stack(
              children: [
                SizedBox(
                  height: context.heightPx * .8,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppAssets.logo,
                        width: 130,
                      ).hero('logo'),
                      const Gap(20),
                      Panel(
                        child: SeparatedColumn(
                          separatorBuilder: () => const Gap(20),
                          children: [
                            const Loader(),
                            Input(
                              TextEditingController(text: '5165'),
                              label: 'Código da sala:',
                              readOnly: true,
                            ),
                            Button.primary(
                              onPressed: () async {
                                _centerController.play();
                              },
                              child: const Text('Button'),
                            ),
                            Button.secondary(onPressed: () async {}, child: const Text('Button Expanded')).expandedH(),
                            Button.secondary(
                              onPressed: () async {},
                              disabled: true,
                              child: const Text('Button Disabled'),
                            ).expandedH(),
                            Button.primary(
                              onPressed: () async {},
                              color: AppColors.red_600,
                              child: const Text('Cancelar'),
                            ).expandedH(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _centerController,
                    // blastDirection: Random().nextInt(360).toDouble(),
                    blastDirectionality: BlastDirectionality.explosive,
                    maxBlastForce: 20,
                    minBlastForce: 5,
                    emissionFrequency: 0.2,

                    // 10 paticles will pop-up at a time
                    numberOfParticles: 10,

                    // particles will pop-up
                    gravity: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
