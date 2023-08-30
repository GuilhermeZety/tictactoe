import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/ui/components/button.dart';
import 'package:tictactoe/app/ui/components/panel.dart';
import 'package:tictactoe/main.dart';

enum ResultScreenType {
  draw,
  win,
  loose,
}

class ResultScreen extends StatefulWidget {
  const ResultScreen.draw({
    super.key,
    required this.room,
    this.backgroundColor = AppColors.grey_500,
    this.textColor = AppColors.grey_200,
    this.message = 'Empate',
  })  : result = ResultScreenType.draw,
        conffetti = false;

  const ResultScreen.win({
    super.key,
    required this.room,
    this.backgroundColor = Colors.black26,
    this.textColor = AppColors.green_400,
    this.message = 'VOCE GANHOU!!!',
    this.conffetti = true,
  }) : result = ResultScreenType.win;

  const ResultScreen.loose({
    super.key,
    required this.room,
    this.backgroundColor = AppColors.red_600,
    this.textColor = AppColors.red_400,
    this.message = 'Você Perdeu',
  })  : result = ResultScreenType.loose,
        conffetti = false;

  final RoomEntity room;
  final Color backgroundColor;
  final Color textColor;
  final String message;
  final ResultScreenType result;
  final bool conffetti;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ConfettiController confettiController = ConfettiController(duration: const Duration(seconds: 2));
  @override
  Widget build(BuildContext context) {
    if (widget.conffetti) {
      confettiController.play();
    }
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
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
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

  Widget get _scoreboard => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${widget.room.victories.$1} - ${widget.room.hostUuid == session.userUuid ? 'Você' : 'Ele'}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.purple_400),
          ),
          Text(
            '${widget.room.victories.$2} - ${widget.room.opponentUuid == session.userUuid ? 'Você' : 'Ele'}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.pink_400),
          ),
        ],
      );
}
