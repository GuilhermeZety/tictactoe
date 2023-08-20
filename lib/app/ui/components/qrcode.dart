import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';

class QrCode extends StatelessWidget {
  const QrCode({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: 1,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: AppColors.white,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: AppColors.white,
      ),
    );
  }
}
