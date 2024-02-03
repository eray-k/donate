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
}
