// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      apiKey: "AIzaSyCcHfiNfMhwn7Sny_dlIm8aBkcviX-WlVg",
      appId: "1:780573810218:web:faaa1bb967007e5f2ced53",
      messagingSenderId: "780573810218",
      authDomain: "quizaic.firebaseapp.com",
      projectId: "quizaic",
      storageBucket: "quizaic.appspot.com",
      measurementId: "G-83X2YBX244");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcHfiNfMhwn7Sny_dlIm8aBkcviX-WlVg',
    appId: '1:780573810218:android:749bf30c655a87c62ced53',
    messagingSenderId: "780573810218",
    projectId: 'quizaic',
    storageBucket: 'quizaic.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcHfiNfMhwn7Sny_dlIm8aBkcviX-WlVg',
    appId: "1:780573810218:ios:a9c47f91444c69ea2ced53",
    messagingSenderId: "780573810218",
    projectId: 'quizaic',
    storageBucket: 'quizaic.appspot.com',
    iosClientId:
        '841686736797-25ib2nurttbn2p7k1hkqhauqcjet1l8j.apps.googleusercontent.com',
    iosBundleId: 'com.google.quizaic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcHfiNfMhwn7Sny_dlIm8aBkcviX-WlVg',
    appId: "1:780573810218:web:faaa1bb967007e5f2ced53",
    messagingSenderId: "780573810218",
    projectId: 'quizaic',
    storageBucket: 'quizaic.appspot.com',
    iosClientId:
        '841686736797-25ib2nurttbn2p7k1hkqhauqcjet1l8j.apps.googleusercontent.com',
    iosBundleId: 'com.google.quizaic',
  );
}
