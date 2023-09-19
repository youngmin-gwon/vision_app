import 'dart:async';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:kmong/application/cam_exception.dart';
import 'package:kmong/application/camera.dart';
import 'package:kmong/application/camera_service.dart';

class CameraServiceDefaultCamImpl implements CameraService {
  final List<CameraDescription> _cameras = [];

  CameraController? _controller;

  bool _isInitialized = false;

  @override
  Future<List<Camera>> getCameras() async {
    if (_cameras.isEmpty) {
      _cameras.addAll(await availableCameras());
    }

    return _cameras.map((e) => BuiltInCamera(e.name)).toList();
  }

  @override
  bool get isInitialized => _controller != null && _isInitialized;

  @override
  Future<void> initialize(Camera camera) async {
    if (isInitialized) {
      throw const CamException.alreadyActive();
    }

    try {
      final List<CameraDescription> cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller!.initialize();
      _isInitialized = true;
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          throw const CamException.accessDenied();
        case 'cameraNotFound':
          throw const CamException.notFound();
        case 'captureFailure':
          throw CamException.captureFailed(message: e.description ?? '');
        case 'videoRecordingFailed':
          throw CamException.recordFailed(message: e.description ?? '');
        case _:
          throw UnimplementedError();
      }
    }
  }

  @override
  Future<Image> takePicture() {
    // TODO: implement takePicture
    throw UnimplementedError();
  }

  @override
  Stream<Image> subscribe() {
    // TODO: implement takeVideo
    throw UnimplementedError();
  }

  @override
  FutureOr<void> unsubscribe() {
    // TODO: implement unsubscribe
    throw UnimplementedError();
  }

  @override
  void close() {
    if (!isInitialized) {
      throw const CamException.notActive();
    }

    _controller?.dispose();
    _isInitialized = false;
  }
}

class BuiltInCamera<String> implements Camera {
  const BuiltInCamera(this._name);

  final String _name;

  @override
  String get identifier => _name;

  @override
  CameraType get type => CameraType.builtIn;
}
