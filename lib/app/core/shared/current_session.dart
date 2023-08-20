import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/app/core/common/utils/uuid.dart';
import 'package:tictactoe/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

class CurrentSession {
  //SingleTon
  CurrentSession._();
  static final CurrentSession _instance = CurrentSession._();
  factory CurrentSession() => CurrentSession._instance;
  //

  late SharedPreferences prefs;
  late FirebaseApp firebaseApp;
  late FirebaseDatabase database;
  String? userUuid;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    //initiation firebase
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    database = FirebaseDatabase.instanceFor(app: firebaseApp);

    userUuid = prefs.getString('userUuid');

    if (userUuid == null) {
      userUuid = Uuid.gen();
      await prefs.setString('userUuid', userUuid!);
    }
  }
}
