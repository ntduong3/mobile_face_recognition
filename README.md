# mobile_face_recognition

A Flutter starter project for mobile face recognition using a clean MVVM structure. It includes:

- Home UI with camera preview and capture button
- Base API integration for face recognition (HTTP POST)
- MVVM separation with `data`, `presentation`, and `viewmodels`
- Device preview support for web and desktop during development

## Getting started

1. Install Flutter (https://flutter.dev/docs/get-started/install)
2. Run `flutter pub get`
3. Run on a device/emulator:
   - `flutter run`

### Web preview (Device Preview)

Device preview is enabled in debug/profile builds. To preview in a browser:

```bash
flutter config --enable-web
flutter run -d chrome
```

### Customizing backend URL

You can set the API base URL using `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=https://api.yourserver.com
```

or by editing `lib/core/config/constants.dart`.

## Notes

- The camera implementation uses the `camera` package; run on a real device for best results.
- If you run into permission issues on Android/iOS, ensure the platforms include the required camera permission strings above.
