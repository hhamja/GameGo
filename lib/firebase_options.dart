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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6P9dNhMRKBJ-b7SUVl_Rpno_3a3YLfs4',
    appId: '1:481543250834:android:a9b09149bb3ae43759974b',
    messagingSenderId: '481543250834',
    projectId: 'gamego-ef2ef',
    storageBucket: 'gamego-ef2ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_M7v4kCJOPaPTapXwWAjsuxDEX7lHD6s',
    appId: '1:481543250834:ios:93a339387cdc993159974b',
    messagingSenderId: '481543250834',
    projectId: 'gamego-ef2ef',
    storageBucket: 'gamego-ef2ef.appspot.com',
    androidClientId: '481543250834-0phvlc49joi6lg0n8e1kh5dj426v5ahf.apps.googleusercontent.com',
    iosClientId: '481543250834-r946rnh6mgsq5qa0cp3jthjqkgeg0p77.apps.googleusercontent.com',
    iosBundleId: 'com.example.gamegoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_M7v4kCJOPaPTapXwWAjsuxDEX7lHD6s',
    appId: '1:481543250834:ios:ad24d524b8e48beb59974b',
    messagingSenderId: '481543250834',
    projectId: 'gamego-ef2ef',
    storageBucket: 'gamego-ef2ef.appspot.com',
    androidClientId: '481543250834-0phvlc49joi6lg0n8e1kh5dj426v5ahf.apps.googleusercontent.com',
    iosClientId: '481543250834-9nm8do15s8qieasnc1fqif6gqi6ih85o.apps.googleusercontent.com',
    iosBundleId: 'com.example.gamegoapp.RunnerTests',
  );
}
