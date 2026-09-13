import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('Not configured for iOS.');
      case TargetPlatform.macOS:
        throw UnsupportedError('Not configured for macOS.');
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError('Not configured for Linux.');
      default:
        throw UnsupportedError('Not supported.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCV6p6SCXZo4wKA6CyFfB8XPexvVw4FTH8',
    appId: '1:296575541883:web:56a1d243b616835163b8de',
    messagingSenderId: '296575541883',
    projectId: 'campfut-424f4',
    authDomain: 'campfut-424f4.firebaseapp.com',
    storageBucket: 'campfut-424f4.firebasestorage.app',
    measurementId: 'G-R2N4NHK1EH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCV6p6SCXZo4wKA6CyFfB8XPexvVw4FTH8',
    appId: '1:296575541883:android:placeholder',
    messagingSenderId: '296575541883',
    projectId: 'campfut-424f4',
    storageBucket: 'campfut-424f4.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCV6p6SCXZo4wKA6CyFfB8XPexvVw4FTH8',
    appId: '1:296575541883:windows:placeholder',
    messagingSenderId: '296575541883',
    projectId: 'campfut-424f4',
    storageBucket: 'campfut-424f4.firebasestorage.app',
  );
}