import 'dart:io';
import 'dart:ui';

import 'package:donate/apps/map_app/presentation/controller/location_controller.dart';
import 'package:donate/apps/map_app/presentation/widgets/menu_widget.dart';
import 'package:donate/core/ui/widgets/custom_progress_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/toolset/ui/custom_icons_icons.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool menuOpened = false;
  @override
  Widget build(BuildContext context) {
    final location = ref.watch(locationProvider);
    return Scaffold(
        body: ColoredBox(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Stack(children: [
          _buildMap(location),
          if (!menuOpened)
            Padding(
                // Menu Button
                padding: const EdgeInsets.all(16.0),
                child: IconButton.filled(
                  onPressed: () {
                    setState(() {
                      menuOpened = true;
                    });
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    )),
                    iconSize: 36,
                  ),
                  icon: const Icon(
                    CustomIcons.menu,
                  ),
                )),
          Positioned(
            right: 0,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    //Navigator.of(context).pushNamed('/');
                  },
                  icon: Image.asset(
                    'assets/images/logo_shadow.png',
                    width: 60,
                  ),
                )),
          ),
          Positioned(
              left: 12,
              bottom: 24,
              child: Opacity(
                opacity: 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: Add navigation to list view
                  },
                  style: ElevatedButtonTheme.of(context).style?.copyWith(
                        shape: MaterialStateProperty.resolveWith(
                            (_) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                )),
                      ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 64.0),
                    child: Text("List View"),
                  ),
                ),
              )),
          if (menuOpened)
            FoldableMenu(onBackPressed: () {
              setState(() {
                menuOpened = false;
              });
            })
        ]),
      ),
    ));
  }

  Widget _buildMap(AsyncValue<Position> location) {
    if (!Platform.isAndroid) {
      return const Text("This app is only available on Android");
    }
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
      loading: () =>
          const CustomProgressIndicator(), // TODO: Add custom progress indicator(blinking logo?)
    );
  }
}
