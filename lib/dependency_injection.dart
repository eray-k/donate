import 'package:donate/apps/auth/data/service/remote/auth_service.dart';
import 'package:donate/apps/auth/domain/repository/auth_repository.dart';
import 'package:donate/apps/map_app/data/service/local/location_service.dart';
import 'package:donate/apps/map_app/data/service/remote/alert_service.dart';
import 'package:get_it/get_it.dart';

import 'apps/auth/presentation/controller/auth_controller.dart';

final sl = GetIt.instance;

Future<void> inject() async {
  //Services
  sl.registerSingleton(const LocationService());
  sl.registerSingleton(const AuthService());
  sl.registerSingleton(const AlertService());

  //Repositories
  sl.registerSingleton(AuthRepository(sl<AuthService>()));

  //Controllers
  sl.registerSingleton(AuthController(sl<AuthRepository>()));
}
