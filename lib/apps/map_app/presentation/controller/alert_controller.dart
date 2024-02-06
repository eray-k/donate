import 'package:donate/apps/map_app/data/service/remote/alert_service.dart';
import 'package:donate/apps/map_app/presentation/controller/location_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../dependency_injection.dart';
import '../../domain/model/alert_model.dart';

part 'alert_controller.g.dart';

@riverpod
class Alerts extends _$Alerts {
  @override
  FutureOr<List<Alert>> build() async {
    return await sl<AlertService>().getAlerts();
  }

  //ONLY FOR TESTING
  Future<void> addAlert() async {
    await sl<AlertService>().newAlert((Alert(
        bloodType: "A+",
        criticality: 1,
        description: "Test Location",
        position: ref.watch(locationProvider).value!)));
  }
}
