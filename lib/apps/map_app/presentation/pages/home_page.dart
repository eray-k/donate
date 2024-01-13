import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blood Donations'),
        ),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-33.86, 151.20),
            zoom: 11.0,
          ),
          markers: {
            const Marker(
              markerId: MarkerId('Sydney'),
              position: LatLng(-33.86, 151.20),
            )
          },
        ));
  }
}
