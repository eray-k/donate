import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate/apps/auth/domain/model/position.dart';

class Account {
  final String displayName;
  final String email;
  String? bloodType;
  Position? _position;

  Account(
      {required this.displayName,
      required this.email,
      this.bloodType,
      Position? position})
      : _position = position;
  Position? get position => _position;

  void setPosition(double lattitude, double longitude) => _position = Position(
      latitude: lattitude, longitude: longitude, timestamp: DateTime.now());

  Map<String, dynamic> toDocument() => {
        'displayName': displayName,
        'email': email,
        'bloodType': bloodType,
        'position': _position != null
            ? GeoPoint(_position!.latitude, _position!.longitude)
            : null,
        'lastUpdate': _position != null ? _position!.timestamp : null,
      };
  Account.fromDocument(Map<String, dynamic> doc)
      : email = doc['email'],
        displayName = doc['displayName'],
        bloodType = doc['bloodType'],
        _position = doc['position'] != null
            ? Position(
                latitude: doc['position'].latitude,
                longitude: doc['position'].longitude,
                timestamp: (doc['lastUpdate'] as Timestamp).toDate())
            : null;
}
