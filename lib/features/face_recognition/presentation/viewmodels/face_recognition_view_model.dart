import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

import '../../data/face_recognition_repository.dart';

class FaceRecognitionViewModel extends ChangeNotifier {
  FaceRecognitionViewModel(this._repository);

  final FaceRecognitionRepository _repository;

  CameraController? _controller;
  CameraDescription? _camera;
  String? _result;
  String? _error;
  bool _isBusy = false;

  CameraController? get controller => _controller;
  CameraDescription? get camera => _camera;
  String? get result => _result;
  String? get error => _error;
  bool get isBusy => _isBusy;

  Future<void> init() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _camera = front;
      _controller = CameraController(
        front,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
    } catch (e, stack) {
      _error = 'Không thể khởi tạo camera. Vui lòng thử lại.';
      debugPrint('FaceRecognitionViewModel.init error: $e');
      debugPrint(stack.toString());
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> captureAndRecognize() async {
    if (_controller == null || !_controller!.value.isInitialized || _isBusy) {
      return;
    }

    _isBusy = true;
    _result = null;
    _error = null;
    notifyListeners();

    try {
      final file = await _controller!.takePicture();
      final bytes = await file.readAsBytes();
      final response = await _repository.recognize(bytes);
      _result = response.message;
    } catch (e, stack) {
      _error = 'Lỗi trong quá trình nhận diện. Vui lòng thử lại.';
      debugPrint('FaceRecognitionViewModel.captureAndRecognize error: $e');
      debugPrint(stack.toString());
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }
}
