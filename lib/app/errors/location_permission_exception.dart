class LocationPermissionException implements Exception {
  final String message;

  LocationPermissionException(this.message);

  @override
  String toString() {
    return message;
  }
}
