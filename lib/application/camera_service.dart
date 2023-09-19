import 'dart:async';
import 'dart:ui';

import 'package:kmong/application/camera.dart';

abstract interface class CameraService {
  bool get isInitialized;

  Future<List<Camera>> getCameras();

  Future<void> initialize(Camera camera);

  Future<Image> takePicture();

  Stream<Image> subscribe();

  FutureOr<void> unsubscribe();

  void close() {}
}
