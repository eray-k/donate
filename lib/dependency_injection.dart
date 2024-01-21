import 'package:citrus_blood/apps/map_app/data/service/local/location_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> inject() async {
  //Services
  sl.registerSingleton(const LocationService());

  //Repositories
  //sl.registerSingleton(const ());
}
