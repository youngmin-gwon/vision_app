import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:kmong/application/camera_service.dart';

class CameraServiceDefaultCamImpl implements CameraService {
  CameraController? _controller;

  bool _isInitialized = false;

  @override
  bool get isInitialized => _controller != null && _isInitialized;

  @override
  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller!.initialize();
      _isInitialized = true;
    } on CameraException catch (e) {
      switch (e.code) {}
    }
  }

  @override
  Future<Image> takePicture() {
    // TODO: implement takePicture
    throw UnimplementedError();
  }

  @override
  Stream<Image> takeVideo() {
    // TODO: implement takeVideo
    throw UnimplementedError();
  }

  @override
  void close() {
    _controller?.dispose();
    _isInitialized = false;
  }
}
