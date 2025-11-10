import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyC98A2D6Jf7uL8_QBzg2aAXWgSZre_iiCo',
    appId: '1:869994493944:android:6910c9fd60b9a25ec4c80d',
    messagingSenderId: '869994493944',
    projectId: 'worlddiscovery-61e29',
    storageBucket: 'worlddiscovery-61e29.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOXdFuGMkioN6JciR42hFPLrrggEe-6DM',
    appId: '1:869994493944:ios:25526d5cdc3e0196c4c80d',
    messagingSenderId: '869994493944',
    projectId: 'worlddiscovery-61e29',
    storageBucket: 'worlddiscovery-61e29.firebasestorage.app',
    iosBundleId: 'com.example.worlddiscovery.worldiscovery',
  );

}