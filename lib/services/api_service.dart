import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../config/constants.dart';

class FaceRecognitionResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  FaceRecognitionResponse({required this.success, required this.message, this.data});

  factory FaceRecognitionResponse.fromJson(Map<String, dynamic> json) {
    return FaceRecognitionResponse(
      success: json['success'] == true,
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}

class ApiService {
  /// Sends a base64 payload to the backend for face recognition.
  ///
  /// This method is a minimal stub; replace [API_BASE_URL] and [endpoint]
  /// with your backend implementation.
  static Future<FaceRecognitionResponse> recognizeFace(Uint8List imageBytes) async {
    if (imageBytes.isEmpty) {
      return FaceRecognitionResponse(success: false, message: 'Không có ảnh để gửi.');
    }

    final base64Image = base64Encode(imageBytes);
    final uri = Uri.parse('$API_BASE_URL/face/recognize');

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'imageBase64': base64Image}),
      );

      if (response.statusCode != 200) {
        return FaceRecognitionResponse(success: false, message: 'Lỗi máy chủ (${response.statusCode}).');
      }

      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return FaceRecognitionResponse.fromJson(payload);
    } catch (e) {
      return FaceRecognitionResponse(success: false, message: 'Không thể kết nối đến dịch vụ nhận diện.');
    }
  }
}
