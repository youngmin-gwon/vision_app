sealed class CameraException implements Exception {
  const CameraException();

  const factory CameraException.accessDenied() = AccessDeniedCameraException;
  const factory CameraException.notFound() = AccessDeniedCameraException;
}

class AccessDeniedCameraException extends CameraException {
  const AccessDeniedCameraException();
}

class NotFoundCameraException extends CameraException {
  const NotFoundCameraException();
}
