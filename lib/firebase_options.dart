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
    apiKey: 'AIzaSyCapoJv4m0PRYVwaOXUimkf7nU-MqDjOFo',
    appId: '1:665460987127:web:274768292a9183181aeff2',
    messagingSenderId: '665460987127',
    projectId: 'waterdropdash-d9c96',
    authDomain: 'waterdropdash-d9c96.firebaseapp.com',
    storageBucket: 'waterdropdash-d9c96.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZt9w6Bvx7w3ZCW1P0RSvSHs7S1KfJKuo',
    appId: '1:665460987127:android:ec363eed5bd1efa71aeff2',
    messagingSenderId: '665460987127',
    projectId: 'waterdropdash-d9c96',
    storageBucket: 'waterdropdash-d9c96.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-PMKZpr2G6V_2mtwUsstROgHlLR9uvBk',
    appId: '1:665460987127:ios:cd255541d86c641f1aeff2',
    messagingSenderId: '665460987127',
    projectId: 'waterdropdash-d9c96',
    storageBucket: 'waterdropdash-d9c96.appspot.com',
    iosBundleId: 'com.example.waterdropdash',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-PMKZpr2G6V_2mtwUsstROgHlLR9uvBk',
    appId: '1:665460987127:ios:cd255541d86c641f1aeff2',
    messagingSenderId: '665460987127',
    projectId: 'waterdropdash-d9c96',
    storageBucket: 'waterdropdash-d9c96.appspot.com',
    iosBundleId: 'com.example.waterdropdash',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCapoJv4m0PRYVwaOXUimkf7nU-MqDjOFo',
    appId: '1:665460987127:web:6c38390b2ebc536a1aeff2',
    messagingSenderId: '665460987127',
    projectId: 'waterdropdash-d9c96',
    authDomain: 'waterdropdash-d9c96.firebaseapp.com',
    storageBucket: 'waterdropdash-d9c96.appspot.com',
  );

}