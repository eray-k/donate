import 'package:donate/apps/auth/domain/model/position.dart';

class Account {
  final String displayName;
  final String email;
  String? bloodType;
  Position? _position;

  Account({required this.displayName, required this.email, this.bloodType});
  get position => _position;

  void setPosition(double lattitude, double longitude) => _position = Position(
      latitude: lattitude, longitude: longitude, timestamp: DateTime.now());
}
