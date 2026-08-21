# routine-manager

[English](./README.md) | [한국어](./README.ko.md)

A mobile habit tracker — check off daily routines and build up a streak. Rebuilt from a web (Next.js) MVP into a Flutter app, since habit-checking happens throughout the day, away from a desk.

![Flutter](https://img.shields.io/badge/Flutter-3.12-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/DB-SQLite-003B57?logo=sqlite&logoColor=white)

## Features

- Add/remove routines
- Mark today complete (once per day)
- Streak counter, incremented on each completion
- Local-only storage (SQLite) — no backend, single-user app

## Tech Stack

- Flutter + Dart
- `sqflite` (mobile) / `sqflite_common_ffi` (Windows/Linux desktop, for easy local testing without an emulator)

## Getting Started

Flutter needs a real display to run, so this can't be developed inside Docker — install directly on your host.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android SDK command-line tools + a JDK (Android Studio not required — see [Android setup without Android Studio](https://developer.android.com/tools) for the `cmdline-tools`/`sdkmanager` path)
- A physical Android device with USB debugging enabled (Settings → About phone → tap Build number 7x → Settings → Developer options → USB debugging), connected via a data-capable USB cable
- Windows desktop target needs Visual Studio ("Desktop development with C++" workload) — not required if you're only targeting Android

### Run

```bash
git clone https://github.com/dev1f965x/routine-manager.git
cd routine-manager
flutter pub get

# with a device connected (flutter devices to list):
flutter run
```

### Test

```bash
flutter analyze
flutter test
```

## Roadmap

- [ ] Local notifications (reminders) via `flutter_local_notifications`
- [ ] Reset streak if a day is missed
- [ ] Weekly/monthly completion rate stats
- [ ] Android APK build for daily use on a physical phone
