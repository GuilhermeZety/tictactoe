import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:gap/gap.dart';
import 'package:tictactoe/app/core/common/constants/app_colors.dart';
import 'package:tictactoe/app/core/common/extensions/context_extension.dart';
import 'package:tictactoe/app/core/common/extensions/widget_extension.dart';
import 'package:tictactoe/app/core/common/utils/vibrate.dart';

class Toasting {
  static void error(
    BuildContext context, {
    String? title,
    String? description,
    Duration? duration,
    StackTrace? stackTrace,
  }) {
    log(
      title ?? 'Erro',
      error: Exception(
        description ?? 'Erro',
      ),
      stackTrace: stackTrace,
    );
    vibrate(FeedbackType.error);
    showNotification(
      context,
      color: AppColors.red_400,
      title: title ?? 'Erro',
      icon: const Icon(
        Icons.error,
        color: AppColors.white,
      ),
      duration: duration,
      description: description,
    );
  }

  static void success(
    BuildContext context, {
    String? title,
    String? description,
    Duration? duration,
  }) {
    vibrate(FeedbackType.success);
    showNotification(
      context,
      color: AppColors.green_400,
      title: title ?? 'Sucesso',
      icon: const Icon(
        Icons.check_circle,
        color: AppColors.white,
      ),
      duration: duration,
      description: description,
    );
  }

  static void noConnection(
    BuildContext context, {
    String? title,
    String? description,
    Duration? duration,
  }) {
    vibrate(FeedbackType.error);
    showNotification(
      context,
      color: AppColors.red_400,
      title: title ?? 'Sem conexão com a internet',
      icon: const Icon(
        Icons.wifi_off_rounded,
        color: AppColors.white,
      ),
      duration: duration,
      description: description,
    );
  }

  static void warning(
    BuildContext context, {
    String? title,
    String? description,
    Duration? duration,
  }) {
    vibrate(FeedbackType.warning);
    showNotification(
      context,
      color: Colors.yellow.shade800,
      title: title ?? 'Aviso',
      icon: const Icon(
        Icons.warning,
        color: AppColors.white,
      ),
      duration: duration,
      description: description,
    );
  }

  static void showNotification(
    BuildContext context, {
    required Color color,
    required String title,
    String? description,
    required Widget icon,
    Duration? duration,
  }) {
    BotToast.showCustomNotification(
      backButtonBehavior: BackButtonBehavior.close,
      duration: duration ?? const Duration(seconds: 10),
      toastBuilder: (close) {
        return _CustomWidget(
          cancelFunc: close,
          title: title,
          color: color,
          description: description,
          icon: icon,
        );
      },
    );
  }
}

class _CustomWidget extends StatefulWidget {
  const _CustomWidget({
    required this.cancelFunc,
    required this.title,
    required this.color,
    this.description,
    required this.icon,
  });

  final CancelFunc cancelFunc;
  final String title;
  final String? description;
  final Widget icon;
  final Color color;

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<_CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.all(3),
            color: Colors.black.withOpacity(0.05),
            child: Container(
              color: AppColors.white,
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: (context.widthPx - 20) * 0.2,
                          color: widget.color,
                          child: Row(
                            children: [
                              Gap(((context.widthPx - 20) * 0.3) * 0.2),
                              widget.icon,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(
                        (context.widthPx - 20) * 0.2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: widget.description != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              widget.title,
                              maxLines: 2,
                              style: const TextStyle(
                                color: AppColors.grey_600,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (widget.description != null) ...[
                              const Gap(10),
                              Text(
                                widget.description!,
                                style: TextStyle(
                                  color: AppColors.grey_600.withOpacity(0.5),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ).expanded(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: widget.cancelFunc,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10, top: 10),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
