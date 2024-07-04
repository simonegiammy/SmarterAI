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
    apiKey: 'AIzaSyCgIvmLdBcXbQuZvwLRWRaUfGENQzNJHoo',
    appId: '1:763690946827:web:25da36d19027180d74520e',
    messagingSenderId: '763690946827',
    projectId: 'smarterai-29ddf',
    authDomain: 'smarterai-29ddf.firebaseapp.com',
    storageBucket: 'smarterai-29ddf.appspot.com',
    measurementId: 'G-GTCGPL7PCS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkVHBkbr-Sz5yc9lBgDf4FuCHwWRcSMeE',
    appId: '1:763690946827:android:63f097d5c2d1dbaa74520e',
    messagingSenderId: '763690946827',
    projectId: 'smarterai-29ddf',
    storageBucket: 'smarterai-29ddf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1mUXVS_DdOX757I5D1TciYm3Sy_cW9-Y',
    appId: '1:763690946827:ios:a2dd4cf349941faf74520e',
    messagingSenderId: '763690946827',
    projectId: 'smarterai-29ddf',
    storageBucket: 'smarterai-29ddf.appspot.com',
    iosBundleId: 'com.example.geminiExample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1mUXVS_DdOX757I5D1TciYm3Sy_cW9-Y',
    appId: '1:763690946827:ios:a2dd4cf349941faf74520e',
    messagingSenderId: '763690946827',
    projectId: 'smarterai-29ddf',
    storageBucket: 'smarterai-29ddf.appspot.com',
    iosBundleId: 'com.example.geminiExample',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgIvmLdBcXbQuZvwLRWRaUfGENQzNJHoo',
    appId: '1:763690946827:web:7a7800c9b5fc931274520e',
    messagingSenderId: '763690946827',
    projectId: 'smarterai-29ddf',
    authDomain: 'smarterai-29ddf.firebaseapp.com',
    storageBucket: 'smarterai-29ddf.appspot.com',
    measurementId: 'G-RG0XSCF25Q',
  );
}