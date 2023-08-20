import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/constants/app_routes.dart';
import 'package:tictactoe/app/core/common/services/connection/connection_service.dart';

class SplashService {
  Future<void> navigate() async {
    if (await Modular.get<ConnectionService>().isConnected) {
      Future.delayed(4.seconds, () => Modular.to.navigate(AppRoutes.home));
      return;
    }
    Future.delayed(4.seconds, () => Modular.to.navigate(AppRoutes.notConnection));
    return;
  }
}
