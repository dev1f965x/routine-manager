# routine-manager

[English](./README.md) | [한국어](./README.ko.md)

매일 루틴을 완료 체크하고 연속 기록(streak)을 쌓는 모바일 습관 트래커. 원래 웹(Next.js) MVP였다가, "루틴 체크는 하루 종일 컴퓨터 밖에서 일어난다"는 이유로 Flutter 앱으로 다시 만들었습니다.

![Flutter](https://img.shields.io/badge/Flutter-3.12-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/DB-SQLite-003B57?logo=sqlite&logoColor=white)

## 기능

- 루틴 추가/삭제
- 오늘 완료 체크 (하루에 한 번만 가능)
- 완료할 때마다 streak(연속 일수) 증가
- 로컬 저장(SQLite)만 사용 — 서버 없음, 1인용 앱

## 기술 스택

- Flutter + Dart
- `sqflite`(모바일) / `sqflite_common_ffi`(Windows/Linux 데스크톱 — 에뮬레이터 없이 로컬 테스트용)

## 시작하기

Flutter는 실제 화면이 필요해서 Docker 안에서 개발할 수 없어요 — 호스트에 직접 설치해야 합니다.

### 필요한 것

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android SDK 커맨드라인 도구 + JDK (Android Studio 없이 `cmdline-tools`/`sdkmanager`만으로 설치 가능)
- USB 디버깅 켠 실제 안드로이드 폰 (설정 → 휴대전화 정보 → 빌드 번호 7번 연타 → 설정 → 개발자 옵션 → USB 디버깅), 데이터 전송 되는 USB 케이블로 연결
- Windows 데스크톱 타겟은 Visual Studio("C++를 사용한 데스크톱 개발" 워크로드)가 필요함 — Android만 쓸 거면 필요 없음

### 실행

```bash
git clone https://github.com/dev1f965x/routine-manager.git
cd routine-manager
flutter pub get

# 기기 연결 후 (flutter devices로 목록 확인):
flutter run
```

### 테스트

```bash
flutter analyze
flutter test
```

## 로드맵

- [ ] `flutter_local_notifications`로 로컬 알림(리마인더)
- [ ] 하루 놓치면 streak 초기화
- [ ] 주간/월간 완료율 통계
- [ ] 실제 폰에서 쓸 Android APK 빌드
