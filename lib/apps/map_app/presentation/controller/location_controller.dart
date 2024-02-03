import 'package:donate/dependency_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../auth/domain/model/position.dart';
import '../../data/service/local/location_service.dart';

part 'location_controller.g.dart';

@riverpod
class Location extends _$Location {
  @override
  FutureOr<Position> build() async {
    return sl<LocationService>().getLocation();
  }
}
