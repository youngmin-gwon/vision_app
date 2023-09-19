import 'dart:ui';

import 'package:kmong/application/cam_exception.dart';
import 'package:kmong/application/camera.dart';
import 'package:usb_serial/usb_serial.dart';

import 'package:kmong/application/camera_service.dart';

class CameraServiceAndroidUsbSerialImpl implements CameraService {
  @override
  Future<List<Camera>> getCameras() {
    // TODO: implement getCameras
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() async {
    // final devices = await UsbSerial.listDevices();
  }

  @override
  // TODO: implement isInitialized
  bool get isInitialized => throw UnimplementedError();

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
    // TODO: implement close
  }

  Future<void> _connect(UsbDevice device) async {
    final port = await device.create();

    if (port == null) {
      throw const CamException.notFound();
    }
  }
}
