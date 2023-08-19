// ignore_for_file: unnecessary_getters_setters

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/app/core/common/services/ulid/ulid.dart';
import 'package:tictactoe/firebase_options.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;
  late FirebaseApp firebaseApp;

  String? userUuid;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    //initiation firebase
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    userUuid = prefs.getString('userUuid');

    if (userUuid == null) {
      userUuid = Uuid.gen();
      await prefs.setString('userUuid', userUuid!);
    }
  }
}
