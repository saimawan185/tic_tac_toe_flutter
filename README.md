# Tic Tac Toe Multiplayer Game in Flutter with Firebase Firestore

Flutter Tic Tac Toe with Firebase Firestore for real-time multiplayer across devices.

## Features

- Firebase Firestore real-time multiplayer sync
- Unique game IDs via `uuid` for create/join
- GetX state management
- Google Fonts (`fredoka`)
- Firebase Crashlytics
- Restart game after a match ends

## Setup (use your own Firebase)

This repo does **not** include Firebase config files. Point the app at your own Firebase project:

1. Create a Firebase project and enable **Cloud Firestore** (and Crashlytics if you want it).
2. Install the FlutterFire CLI and configure the app:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

That generates `lib/firebase_options.dart`, `android/app/google-services.json`, and `ios/Runner/GoogleService-Info.plist`.

3. Install dependencies and run:

```bash
flutter pub get
flutter run
```

## How to Play

- Create a game to get a unique ID and share it with the second player.
- The second player joins with that ID.
- Play with live updates over the network.

## Game Video

https://github.com/saimawan185/tic_tac_toe_flutter/assets/141933915/7623c257-fdb5-4021-a552-cf794ba4bacb

## Contact

- Email: awanmsaim182@gmail.com
- Phone: +923164168178
- LinkedIn: https://www.linkedin.com/in/muhammad-saim-5bab731bb/
