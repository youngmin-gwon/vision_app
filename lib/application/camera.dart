abstract interface class Camera<T> {
  T get identifier;
  CameraType get type;
}

enum CameraType {
  builtIn,
  external,
}
