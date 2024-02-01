import 'dart:async';

import 'package:donate/apps/auth/domain/model/position.dart';
import 'package:donate/apps/map_app/data/service/remote/alert_service.dart';
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

  Future<void> addAlert() async {
    await sl<AlertService>().newAlert(Alert(
        distance: 1,
        criticality: 1,
        description: "Yessssss",
        position:
            Position(latitude: 1, longitude: 1, timestamp: DateTime.now())));
  }
}
