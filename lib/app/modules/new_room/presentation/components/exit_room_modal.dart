import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/core/common/utils/custom_dialog_utils.dart';
import 'package:tictactoe/app/ui/components/button.dart';
import 'package:tictactoe/app/ui/dialogs/custom_dialog.dart';

class ExitRoomModal extends StatelessWidget {
  const ExitRoomModal({super.key});

  static Future<bool?> show(
    BuildContext context,
  ) async {
    return showCustomDialog<bool?>(
      context,
      child: const ExitRoomModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      margin: const EdgeInsets.all(20),
      top: const Text(
        'Tem certeza que deseja abandonar esta partida?',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      bottom: Column(
        children: [
          Button(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: const Text('Confirmar'),
          ).expandedH(),
          const Gap(10),
          Button(
            onPressed: () async {
              Navigator.of(context).pop(false);
            },
            color: AppColors.grey_400,
            child: const Text('Cancelar'),
          ).expandedH(),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Você perderá a partida atual e será redirecionado para a tela inicial.',
          style: TextStyle(color: AppColors.grey_200),
        ),
      ),
    );
  }
}
