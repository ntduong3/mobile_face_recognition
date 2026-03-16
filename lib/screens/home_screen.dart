import 'package:flutter/material.dart';

import '../widgets/face_recognition_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      appBar: AppBar(
        toolbarHeight: 72,
        elevation: 1,
        title: const Text('Nhận diện khuôn mặt'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hãy chụp ảnh để bắt đầu nhận diện. Màn hình này đã tích hợp sẵn camera, thao tác quay/chụp và gọi API.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4E5D78)),
              ),
              SizedBox(height: 16),
              Expanded(child: FaceRecognitionCard()),
            ],
          ),
        ),
      ),
    );
  }
}
