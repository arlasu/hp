// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAcHPqPVauol0unlHFz5v8wUHjpQUbnBzw',
    appId: '1:943013057965:web:5ae06a2c542b899c133d24',
    messagingSenderId: '943013057965',
    projectId: 'nichibi-7308c',
    authDomain: 'nichibi-7308c.firebaseapp.com',
    storageBucket: 'nichibi-7308c.appspot.com',
    measurementId: 'G-T9YJ22E929',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUPhNA8EN36EITsdgjxx87Vzx5Gcr3BFs',
    appId: '1:943013057965:ios:b459f7be7e41ff18133d24',
    messagingSenderId: '943013057965',
    projectId: 'nichibi-7308c',
    storageBucket: 'nichibi-7308c.appspot.com',
    iosBundleId: 'com.example.flutterApplicationEiyou',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUPhNA8EN36EITsdgjxx87Vzx5Gcr3BFs',
    appId: '1:943013057965:ios:b459f7be7e41ff18133d24',
    messagingSenderId: '943013057965',
    projectId: 'nichibi-7308c',
    storageBucket: 'nichibi-7308c.appspot.com',
    iosBundleId: 'com.example.flutterApplicationEiyou',
  );
}
