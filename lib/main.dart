import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/app_module.dart';
import 'package:tictactoe/app/app_widget.dart';
import 'package:tictactoe/app/core/shared/current_session.dart';
import 'package:dart_ping_ios/dart_ping_ios.dart';

/// Quando eu desenvolvi só Eu e Deus sabiamos como funcionava e agora só Deus sabe;
///
/// | $$$$$$$                                                             /$$
/// | $ _   $$                                                           | $$
/// | $$     $$  /$$$$$$    /$$$$$$         /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$    /$$$$$$
/// | $$$$$$$   /$     $$        $$       /$ ____/   / $    $$ / $$  $$|  | $$     /$
/// | $     $$| |$$    $$  / $$$$$$      |  $$$$$$   | $$   $$ | $$       | $$    | $$$$$$$
/// | $$     $$ |$$    $$ /$     $$         ____ $$  | $$  |$$ | $$       | $$    | $ ____/
/// | $$$$$$$/  | $$$$$$/ | $$$$$$$       /$$$$$$$/  |  $$$$$$ | $$       | $$    | $$$$$$$
/// |_______/    ______/  ______/          ____/      ______/  |__/        __       _____/

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
