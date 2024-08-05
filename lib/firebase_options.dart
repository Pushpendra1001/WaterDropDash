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
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCTAB1IaX7Cr_OziBMaVoHglc7ioBaTfJQ',
    appId: '1:185945359703:web:b05addcadb378e2dfaaa12',
    messagingSenderId: '185945359703',
    projectId: 'waterdropdash',
    authDomain: 'waterdropdash.firebaseapp.com',
    storageBucket: 'waterdropdash.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUq5Y931nuCnkVPsw08u2ZMTnRoXfl6Fo',
    appId: '1:185945359703:android:6bb256293c72e437faaa12',
    messagingSenderId: '185945359703',
    projectId: 'waterdropdash',
    storageBucket: 'waterdropdash.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbkwSh-RTsxuj5osJZNV6hbDBW5MpIaIo',
    appId: '1:185945359703:ios:c1c66927f0d773d4faaa12',
    messagingSenderId: '185945359703',
    projectId: 'waterdropdash',
    storageBucket: 'waterdropdash.appspot.com',
    iosBundleId: 'com.example.waterdropdash',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbkwSh-RTsxuj5osJZNV6hbDBW5MpIaIo',
    appId: '1:185945359703:ios:c1c66927f0d773d4faaa12',
    messagingSenderId: '185945359703',
    projectId: 'waterdropdash',
    storageBucket: 'waterdropdash.appspot.com',
    iosBundleId: 'com.example.waterdropdash',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTAB1IaX7Cr_OziBMaVoHglc7ioBaTfJQ',
    appId: '1:185945359703:web:21387e4b5fd33431faaa12',
    messagingSenderId: '185945359703',
    projectId: 'waterdropdash',
    authDomain: 'waterdropdash.firebaseapp.com',
    storageBucket: 'waterdropdash.appspot.com',
  );
}
