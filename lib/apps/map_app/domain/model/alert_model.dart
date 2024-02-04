import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/toolset/distance.dart';
import '../../../auth/domain/model/position.dart';

class Alert {
  final int criticality;
  final Position position;
  final String description;
  final String bloodType;

  const Alert(
      {required this.bloodType,
      required this.description,
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

class AlertWithDistance extends Alert {
  late final int distanceInMeters; // Not stored in Firestore

  AlertWithDistance(Alert alert, Position targetLocation)
      : super(
            bloodType: alert.bloodType,
            description: alert.description,
            criticality: alert.criticality,
            position: alert.position) {
    distanceInMeters = _calculateDistanceInMeters(targetLocation);
  }

  ///Return the distance in meters (rounded to the nearest 10 meters)
  int _calculateDistanceInMeters(Position targetLocation) {
    final dist = distance(targetLocation.latitude, targetLocation.longitude,
        position.latitude, position.longitude);
    final distanceInDesimeters = (dist * 100).round();
    return distanceInDesimeters * 10;
  }

  String toDistanceString() {
    final distanceText = distanceInMeters >= 1000
        ? "${(distanceInMeters / 1000).toStringAsFixed(1)} km"
        : "$distanceInMeters m";
    return distanceText;
  }
}
