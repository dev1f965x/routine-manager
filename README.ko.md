# routine-manager

[English](./README.md) | [한국어](./README.ko.md)

매일 할 루틴을 체크하는 Android 앱입니다. 매일 이어서 완료하면 연속 기록이 쌓이고, 하루라도 빠뜨리면 초기화됩니다. 데이터는 기기에 저장됩니다.

## 빌드

[Flutter SDK](https://docs.flutter.dev/get-started/install)와 Android SDK가 필요합니다.

```bash
flutter pub get
flutter build apk --release
```

USB로 연결한 기기에 설치합니다. `-r`로 설치해야 앱 데이터가 유지되고, `flutter install`은 기존 앱을 지운 뒤 설치해서 데이터가 사라집니다.

```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

## 테스트

```bash
flutter test
```

## 라이선스

[MIT](./LICENSE)
