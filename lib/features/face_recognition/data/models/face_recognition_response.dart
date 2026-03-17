import 'package:equatable/equatable.dart';

class FaceRecognitionResponse extends Equatable {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  const FaceRecognitionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory FaceRecognitionResponse.fromJson(Map<String, dynamic> json) {
    return FaceRecognitionResponse(
      success: json['success'] == true,
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}
