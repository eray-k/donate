import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/toolset/distance.dart';
import '../../../auth/domain/model/position.dart';

class Alert {
  final int criticality;
  final Position position;
  final String? description;
  final String bloodType;

  double distanceFrom(Position targetLocation) => distance(
      targetLocation.latitude,
      targetLocation.longitude,
      position.latitude,
      position.longitude);
  const Alert(
      {required this.bloodType,
      this.description,
      required this.criticality,
      required this.position});

  Map<String, dynamic> toDoc() {
    return {
      'bloodType': bloodType,
      'criticality': criticality,
      'position': GeoPoint(position.latitude, position.longitude),
      'timeStamp': position.timestamp,
      'description': description
    };
  }

  factory Alert.fromDoc(Map<String, dynamic> doc) {
    final geoPoint = doc['position'] as GeoPoint;
    final timeStamp = doc['timeStamp'] as Timestamp;
    return Alert(
        bloodType: doc['bloodType'],
        criticality: doc['criticality'],
        position: Position(
            latitude: geoPoint.latitude,
            longitude: geoPoint.longitude,
            timestamp: timeStamp.toDate()),
        description: doc['description']);
  }
}
