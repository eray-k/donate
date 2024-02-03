import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/toolset/distance.dart';
import '../../../auth/domain/model/position.dart';

class Alert {
  final int criticality;
  final Position position;
  final String? description;
  double distanceFrom(Position targetLocation) => distance(
      targetLocation.latitude,
      targetLocation.longitude,
      position.latitude,
      position.longitude);
  const Alert(
      {this.description, required this.criticality, required this.position});
  Map<String, dynamic> toDoc() {
    return {
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
        criticality: doc['criticality'],
        position: Position(
            latitude: geoPoint.latitude,
            longitude: geoPoint.longitude,
            timestamp: timeStamp.toDate()),
        description: doc['description']);
  }
}
