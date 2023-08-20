import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/firebase_options.dart';

class FirebaseService {
  static void binds(Injector i) async {
    var firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    i.addSingleton<FirebaseApp>(() => firebaseApp);
    i.addSingleton<FirebaseDatabase>(() => FirebaseDatabase.instanceFor(app: firebaseApp));
  }
}
