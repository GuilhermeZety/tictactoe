import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/services/connection/ping_connection_service_impl.dart';
import 'package:tictactoe/app/core/common/services/requests/dio_request_service.dart';
import 'package:tictactoe/app/core/common/services/requests/request_service.dart';
import 'package:tictactoe/app/core/common/utils/toasting.dart';
import 'package:tictactoe/app/modules/home/presentation/pages/home_page.dart';
import 'package:tictactoe/app/modules/join_room/presentation/pages/join_room_page.dart';
import 'package:tictactoe/app/modules/new_room/presentation/pages/new_room_page.dart';
import 'package:tictactoe/app/modules/not_connection/presenter/not_connection_page.dart';
import 'package:tictactoe/app/modules/not_found/presentation/pages/not_found_page.dart';
import 'package:tictactoe/app/modules/splash/presentation/pages/splash_page.dart';

import 'package:tictactoe/app/core/common/services/connection/connection_service.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ConnectionService>(() => PingConnectionServiceImpl());
    i.addSingleton<RequestService>(() => DioRequestService());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const SplashPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/not_connection',
      child: (args) => const NotConnectionPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/home/',
      child: (args) => const HomePage(),
      transition: TransitionType.fadeIn,
      duration: 700.ms,
    );
    r.child(
      '/new_room/',
      child: (args) {
        if (r.args.data is int) {
          return NewRoomPage(
            roomID: r.args.data,
          );
        }
        Toasting.error(args, message: 'Erro ao criar sala');
        Modular.to.navigate(AppRoutes.splash);
        return const SizedBox.shrink();
      },
      transition: TransitionType.fadeIn,
      duration: 300.ms,
    );
    r.child(
      '/join_room/',
      child: (args) => const JoinRoomPage(),
      transition: TransitionType.fadeIn,
      duration: 300.ms,
    );
    r.wildcard(child: (args) => const NotFoundPage());
  }
}
