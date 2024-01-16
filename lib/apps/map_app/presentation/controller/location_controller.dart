import 'package:citrus_blood/dependency_injection.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/service/local/location_service.dart';

part 'location_controller.g.dart';

@riverpod
class Location extends _$Location {
  @override
  FutureOr<Position> build() async {
    return sl<LocationService>().getLocation();
  }
}
