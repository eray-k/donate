class Position {
  final double latitude;
  final double longitude;
  final DateTime? timestamp; // When is the data acquired

  const Position(
      {required this.latitude,
      required this.longitude,
      required this.timestamp});

  @override
  bool operator ==(covariant Position other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
