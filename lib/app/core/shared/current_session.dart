import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/app/core/common/utils/uuid.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;

  String? userUuid;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    //initiation firebase

    userUuid = prefs.getString('userUuid');

    if (userUuid == null) {
      userUuid = Uuid.gen();
      await prefs.setString('userUuid', userUuid!);
    }
  }
}
