import 'dart:typed_data';

import 'face_recognition_api.dart';
import 'models/face_recognition_response.dart';

class FaceRecognitionRepository {
  FaceRecognitionRepository(this._api);

  final FaceRecognitionApi _api;

  Future<FaceRecognitionResponse> recognize(Uint8List imageBytes) {
    return _api.recognizeFace(imageBytes);
  }
}
