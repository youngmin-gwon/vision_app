import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:kmong/application/cam_exception.dart';
import 'package:kmong/application/camera.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

import 'package:kmong/application/camera_service.dart';

class CameraServiceAndroidUsbSerialImpl implements CameraService {
  final List<UsbDevice> _devices = [];

  UsbPort? _port;
  StreamController<String>? _controller;
  Transaction<String>? _transaction;

  @override
  Future<List<Camera>> getCameras() async {
    if (_devices.isEmpty) {
      _devices.addAll(await UsbSerial.listDevices());
    }

    return _devices.map((e) => UsbCamera(e.deviceId ?? -1)).toList();
  }

  @override
  Future<void> initialize(Camera camera) async {
    if (!isInitialized) {
      throw const CamException.alreadyActive();
    }

    try {
      /// throws [StateError] if nothing is found
      final device = _devices
          .firstWhere((element) => element.deviceId == camera.identifier);

      _port = await device.create();

      final isOpened = await _port!.open();

      if (!isOpened) {
        throw const CamException.connectionFailed();
      }

      await _port!.setDTR(true);
      await _port!.setRTS(true);
      await _port!.setPortParameters(
        2000000,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _transaction = Transaction.stringTerminated(
          _port!.inputStream!, Uint8List.fromList([13, 10]));

      late StreamSubscription<String> subscription;

      _controller = StreamController(
        onPause: () {
          subscription.cancel();
          _controller?.close();
        },
        onCancel: () {
          subscription.cancel();
          _controller?.close();
        },
      );

      subscription = _transaction!.stream.listen(
        _controller!.add,
        onDone: () {
          subscription.cancel();
          _controller?.close();
        },
        onError: (_) {
          subscription.cancel();
          _controller?.close();
        },
      );
    } on StateError {
      throw const CamException.notFound();
    }
  }

  @override
  bool get isInitialized =>
      _port != null || _transaction != null || _controller != null;

  @override
  Future<Image> takePicture() {
    // _checkIfInitialized();

    // _controller!.stream.map((String value) => null).first;

    throw UnimplementedError();
  }

  @override
  Stream<Image> subscribe() {
    _checkIfInitialized();

    // TODO: implement takeVideo
    throw UnimplementedError();
  }

  @override
  FutureOr<void> unsubscribe() {
    _checkIfInitialized();
    throw UnimplementedError();
  }

  @override
  void close() {
    _port?.close();
    _transaction?.dispose();
    _controller?.close();
  }

  void _checkIfInitialized() {
    if (!isInitialized) {
      throw const CamException.notActive();
    }
  }
}

class UsbCamera<int> implements Camera {
  const UsbCamera(this._id);

  final int _id;

  @override
  int get identifier => _id;

  @override
  CameraType get type => CameraType.external;
}
