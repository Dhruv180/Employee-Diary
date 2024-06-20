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
    apiKey: 'AIzaSyDEydOLR_ZSW_g0LNWR_K9icKNaI4XV0iQ',
    appId: '1:901519002202:web:a5db6b45b9bd94216be663',
    messagingSenderId: '901519002202',
    projectId: 'crud-25666',
    authDomain: 'crud-25666.firebaseapp.com',
    storageBucket: 'crud-25666.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6EmL9XuEkxfhK2o_Z_1kYuAcsdcR2kVI',
    appId: '1:901519002202:android:80fa418439c825a86be663',
    messagingSenderId: '901519002202',
    projectId: 'crud-25666',
    storageBucket: 'crud-25666.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDm07rcQBBaICJfq3vsalh6xCOF7RG_jc8',
    appId: '1:901519002202:ios:3dff5a81d29b69026be663',
    messagingSenderId: '901519002202',
    projectId: 'crud-25666',
    storageBucket: 'crud-25666.appspot.com',
    iosBundleId: 'com.example.crudProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDm07rcQBBaICJfq3vsalh6xCOF7RG_jc8',
    appId: '1:901519002202:ios:3dff5a81d29b69026be663',
    messagingSenderId: '901519002202',
    projectId: 'crud-25666',
    storageBucket: 'crud-25666.appspot.com',
    iosBundleId: 'com.example.crudProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEydOLR_ZSW_g0LNWR_K9icKNaI4XV0iQ',
    appId: '1:901519002202:web:cb9991b5974cc3046be663',
    messagingSenderId: '901519002202',
    projectId: 'crud-25666',
    authDomain: 'crud-25666.firebaseapp.com',
    storageBucket: 'crud-25666.appspot.com',
  );

}