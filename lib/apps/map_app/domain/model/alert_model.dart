import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../auth/domain/model/position.dart';

class Alert {
  final int criticality;
  final Position position;
  final String? description;
  final int distance; //in meters
  const Alert(
      {this.description,
      required this.distance,
      required this.criticality,
      required this.position});
  Map<String, dynamic> toDoc() {
    return {
      'criticality': criticality,
      'position': GeoPoint(position.latitude, position.longitude),
      'timeStamp': position.timestamp,
      'distance': distance,
      'description': description
    };
  }

  factory Alert.fromDoc(Map<String, dynamic> doc) {
    final geoPoint = doc['position'] as GeoPoint;
    final timeStamp = doc['timeStamp'] as Timestamp;
    return Alert(
        criticality: doc['criticality'],
        distance: doc['distance'],
        position: Position(
            latitude: geoPoint.latitude,
            longitude: geoPoint.longitude,
            timestamp: timeStamp.toDate()),
        description: doc['description']);
  }
}
