# mobile_face_recognition

A starter Flutter project with a clean home screen for face recognition. It includes:

- A beautiful home UI with camera preview and capture button
- Base API integration for face recognition (HTTP POST)
- Camera permission handling (Android/iOS)

## Getting started

1. Install Flutter (https://flutter.dev/docs/get-started/install)
2. Run `flutter pub get`
3. Run on a device/emulator:
   - `flutter run`

### Customizing backend URL

You can set the API base URL using `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=https://api.yourserver.com
```

or by editing `lib/config/constants.dart`.

## Notes

- The camera implementation uses the `camera` package; run on a real device for best results.
- If you run into permission issues on Android/iOS, ensure the platforms include the required camera permission strings above.
