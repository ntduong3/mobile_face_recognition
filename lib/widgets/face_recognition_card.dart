import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class FaceRecognitionCard extends StatefulWidget {
  const FaceRecognitionCard({super.key});

  @override
  State<FaceRecognitionCard> createState() => _FaceRecognitionCardState();
}

class _FaceRecognitionCardState extends State<FaceRecognitionCard> {
  CameraController? _controller;
  CameraDescription? _camera;
  String? _result;
  bool _isBusy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _camera = front;
      _controller = CameraController(front, ResolutionPreset.medium, enableAudio: false);
      await _controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      setState(() {
        _error = 'Không thể khởi tạo camera. Vui lòng thử lại.';
      });
    }
  }

  Future<void> _captureAndRecognize() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isBusy = true;
      _result = null;
      _error = null;
    });

    try {
      final file = await _controller!.takePicture();
      final bytes = await File(file.path).readAsBytes();
      final response = await ApiService.recognizeFace(bytes);

      setState(() {
        _result = response.message;
      });
    } catch (e) {
      setState(() {
        _error = 'Lỗi trong quá trình nhận diện. Vui lòng thử lại.';
      });
    } finally {
      setState(() {
        _isBusy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Expanded(
              child: _buildCameraPreview(theme),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: _isBusy ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.camera_alt),
                          label: const Text('Nhận diện'),
                          onPressed: _isBusy || _controller == null || !_controller!.value.isInitialized ? null : _captureAndRecognize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_error != null)
                    Text(
                      _error!,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                  if (_result != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kết quả:', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 4),
                        Text(_result!, style: theme.textTheme.bodyLarge),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview(ThemeData theme) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(_error!, style: theme.textTheme.bodyMedium),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return CameraPreview(_controller!);
  }
}
