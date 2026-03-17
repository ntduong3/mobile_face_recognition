import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/face_recognition/data/face_recognition_api.dart';
import '../../features/face_recognition/data/face_recognition_repository.dart';
import '../../features/face_recognition/presentation/viewmodels/face_recognition_view_model.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  if (getIt.isRegistered<http.Client>()) {
    return;
  }

  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FaceRecognitionApi>(
    () => FaceRecognitionApi(getIt<http.Client>()),
  );
  getIt.registerLazySingleton<FaceRecognitionRepository>(
    () => FaceRecognitionRepository(getIt<FaceRecognitionApi>()),
  );
  getIt.registerFactory<FaceRecognitionViewModel>(
    () => FaceRecognitionViewModel(getIt<FaceRecognitionRepository>()),
  );
}
