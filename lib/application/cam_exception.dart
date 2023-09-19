/// it was originally designed to name `CameraException`,
/// but changed to `CamException` because of same exception
/// in `camera` library
sealed class CamException implements Exception {
  const CamException();

  const factory CamException.notActive() = NotActiveCamException;
  const factory CamException.alreadyActive() = AlreadyActiveCamException;
  const factory CamException.accessDenied() = AccessDeniedCamException;
  const factory CamException.notFound() = AccessDeniedCamException;
  const factory CamException.connectionFailed() = AccessDeniedCamException;
  const factory CamException.captureFailed({required String message}) =
      CaptureFailedCamException;
  const factory CamException.recordFailed({required String message}) =
      RecordFailedCamException;
}

class NotActiveCamException extends CamException {
  const NotActiveCamException();
}

class AlreadyActiveCamException extends CamException {
  const AlreadyActiveCamException();
}

class AccessDeniedCamException extends CamException {
  const AccessDeniedCamException();
}

class FailedConnectionCamException extends CamException {
  const FailedConnectionCamException();
}

class NotFoundCamException extends CamException {
  const NotFoundCamException();
}

class CaptureFailedCamException extends CamException {
  const CaptureFailedCamException({required this.message});

  final String message;
}

class RecordFailedCamException extends CamException {
  const RecordFailedCamException({required this.message});

  final String message;
}
