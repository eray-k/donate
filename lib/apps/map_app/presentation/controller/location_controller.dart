import 'package:donate/dependency_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/domain/model/position.dart';
import '../../data/service/local/location_service.dart';

final locationProvider = StreamProvider<Position>((ref) async* {
  yield await sl<LocationService>().getLocation();
});
