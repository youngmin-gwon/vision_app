class Camera {
  const Camera(this.id);

  final String id;

  @override
  bool operator ==(covariant Camera other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Camera copyWith({
    String? id,
  }) {
    return Camera(
      id ?? this.id,
    );
  }
}
