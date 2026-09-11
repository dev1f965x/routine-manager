# routine-manager

[English](./README.md) | [한국어](./README.ko.md)

Android app for checking off daily routines. Completing a routine on consecutive days builds a streak, and missing a day resets it. Data is stored on the device.

## Build

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install) and the Android SDK.

```bash
flutter pub get
flutter build apk --release
```

Install on a device connected over USB. `-r` keeps app data; `flutter install` uninstalls the app first and wipes it.

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## Test

```bash
flutter test
```
