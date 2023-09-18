import 'dart:ui';

abstract interface class CameraService {
  bool get isInitialized;

  Future<void> initialize();

  Future<Image> takePicture();

  Stream<Image> takeVideo();

  void close() {}
}
