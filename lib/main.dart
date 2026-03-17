import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/service_locator.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
    if (details.stack != null) {
      debugPrint(details.stack.toString());
    }
  };

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MobileFaceRecognitionApp(),
    ),
  );
}
