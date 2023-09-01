import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/utils/toasting.dart';
import 'package:tictactoe/app/modules/game/presentation/cubit/game_cubit.dart';
import 'package:tictactoe/app/modules/game/presentation/pages/game_page.dart';

class GameModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<GameCubit>(() => GameCubit());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) {
        if (r.args.data is int) {
          return GamePage(
            roomID: r.args.data,
          );
        }
        Toasting.error(context, message: 'Erro ao entrar na sala');
        Modular.to.navigate(AppRoutes.splash);
        return const SizedBox.shrink();
      },
      transition: TransitionType.fadeIn,
      duration: 300.ms,
    );
  }
}
