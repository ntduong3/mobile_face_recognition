import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../core/config/constants.dart';
import 'models/face_recognition_response.dart';

class FaceRecognitionApi {
  FaceRecognitionApi(this._client);

  final http.Client _client;

  Future<FaceRecognitionResponse> recognizeFace(Uint8List imageBytes) async {
    if (imageBytes.isEmpty) {
      return const FaceRecognitionResponse(
        success: false,
        message: 'Không có ảnh để gửi.',
      );
    }

    final base64Image = base64Encode(imageBytes);
    final uri = Uri.parse('$apiBaseUrl/face/recognize');

    try {
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'imageBase64': base64Image}),
      );

      if (response.statusCode != 200) {
        debugPrint(
          'FaceRecognitionApi.recognizeFace status ${response.statusCode}: ${response.body}',
        );
        return FaceRecognitionResponse(
          success: false,
          message: 'Lỗi máy chủ (${response.statusCode}).',
        );
      }

      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return FaceRecognitionResponse.fromJson(payload);
    } catch (e, stack) {
      debugPrint('FaceRecognitionApi.recognizeFace error: $e');
      debugPrint(stack.toString());
      return const FaceRecognitionResponse(
        success: false,
        message: 'Không thể kết nối đến dịch vụ nhận diện.',
      );
    }
  }
}
