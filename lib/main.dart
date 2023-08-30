import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/app_module.dart';
import 'package:tictactoe/app/app_widget.dart';
import 'package:tictactoe/app/core/shared/current_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPingIOS.register();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await session.init();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

CurrentSession session = CurrentSession();
