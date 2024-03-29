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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
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
    apiKey: 'AIzaSyBwcf4YN1wJccj2PHfchFAM9sgj-WdvEB0',
    appId: '1:208948765893:web:1237e05e99ed0976fabcac',
    messagingSenderId: '208948765893',
    projectId: 'portakal-mobile-user-app',
    authDomain: 'portakal-mobile-user-app.firebaseapp.com',
    storageBucket: 'portakal-mobile-user-app.appspot.com',
    measurementId: 'G-2S1T2H55MB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXNP_baePNsSgefouvzdYlJLNlCfnTfaw',
    appId: '1:208948765893:android:00f1e46c5cbfe7b9fabcac',
    messagingSenderId: '208948765893',
    projectId: 'portakal-mobile-user-app',
    storageBucket: 'portakal-mobile-user-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRkAZuEizIvLxoYOoXokf1L9YG6CUOAhY',
    appId: '1:208948765893:ios:39f218d6ae4a2e7ffabcac',
    messagingSenderId: '208948765893',
    projectId: 'portakal-mobile-user-app',
    storageBucket: 'portakal-mobile-user-app.appspot.com',
    iosBundleId: 'com.example.portakalMobileUserApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRkAZuEizIvLxoYOoXokf1L9YG6CUOAhY',
    appId: '1:208948765893:ios:2f0d8d170eb931e1fabcac',
    messagingSenderId: '208948765893',
    projectId: 'portakal-mobile-user-app',
    storageBucket: 'portakal-mobile-user-app.appspot.com',
    iosBundleId: 'com.example.portakalMobileUserApp.RunnerTests',
  );
}
