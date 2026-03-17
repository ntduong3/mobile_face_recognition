import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/face_recognition_view_model.dart';

class FaceRecognitionCard extends StatelessWidget {
  const FaceRecognitionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FaceRecognitionViewModel>();
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Expanded(
              child: _buildCameraPreview(viewModel, theme),
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
                          icon: viewModel.isBusy
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.camera_alt),
                          label: const Text('Nhận diện'),
                          onPressed: viewModel.isBusy ||
                                  viewModel.controller == null ||
                                  !(viewModel.controller?.value.isInitialized ?? false)
                              ? null
                              : viewModel.captureAndRecognize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (viewModel.error != null)
                    Text(
                      viewModel.error!,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.error),
                    ),
                  if (viewModel.result != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kết quả:', style: theme.textTheme.labelLarge),
                        const SizedBox(height: 4),
                        Text(
                          viewModel.result!,
                          style: theme.textTheme.bodyLarge,
                        ),
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

  Widget _buildCameraPreview(
    FaceRecognitionViewModel viewModel,
    ThemeData theme,
  ) {
    if (viewModel.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(viewModel.error!, style: theme.textTheme.bodyMedium),
        ),
      );
    }

    final controller = viewModel.controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return CameraPreview(controller);
  }
}
