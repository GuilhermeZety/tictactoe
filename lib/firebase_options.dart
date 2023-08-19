// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfeZBg2-Q23fgMBfc3ySxSuHn2DIMaK-A',
    appId: '1:361052894790:android:7437f913818c689f0bfc47',
    messagingSenderId: '361052894790',
    projectId: 'tictactoe-z',
    databaseURL: 'https://tictactoe-z-default-rtdb.firebaseio.com',
    storageBucket: 'tictactoe-z.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUFqGYcJ8ahupkC6enFH2Yhrq86Mj_ltE',
    appId: '1:361052894790:ios:957215bf727edf240bfc47',
    messagingSenderId: '361052894790',
    projectId: 'tictactoe-z',
    databaseURL: 'https://tictactoe-z-default-rtdb.firebaseio.com',
    storageBucket: 'tictactoe-z.appspot.com',
    iosClientId: '361052894790-4plnc0kok4k6t1lde9n9jkndi4mluurh.apps.googleusercontent.com',
    iosBundleId: 'br.com.zety.tictactoe',
  );
}
