import 'package:citrus_blood/apps/map_app/presentation/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blood Donations'),
          automaticallyImplyLeading: false,
        ),
        body: _buildMap(location));
  }

  Widget _buildMap(AsyncValue<Position> location) {
    return location.when(
      data: (data) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(data.latitude, data.longitude),
            zoom: 11.0,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('Your Location'),
              position: LatLng(data.latitude, data.longitude),
            )
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
