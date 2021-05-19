class LocationPermissionException implements Exception {
  final String message;

  const LocationPermissionException(this.message);

  @override
  String toString() {
    return message;
  }
}
