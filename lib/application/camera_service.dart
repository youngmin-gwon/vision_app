import 'dart:ui';

import 'package:kmong/application/camera.dart';

abstract interface class CameraService {
  bool get isInitialized;

  Future<List<Camera>> getCameras();

  Future<void> initialize();

  Future<Image> takePicture();

  Stream<Image> takeVideo();

  void close() {}
}
