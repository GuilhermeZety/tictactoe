import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/services/connection/ping_connection_service_impl.dart';
import 'package:tictactoe/app/core/common/services/requests/dio_request_service.dart';
import 'package:tictactoe/app/core/common/services/requests/request_service.dart';
import 'package:tictactoe/app/modules/home/presentation/pages/home_page.dart';
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
      '/home/',
      child: (args) => const HomePage(),
      transition: TransitionType.fadeIn,
      duration: 500.ms,
    );
  }
}
