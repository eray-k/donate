import 'dart:io';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:donate/apps/auth/presentation/widgets/my_circle_avatar.dart';
import 'package:donate/apps/map_app/domain/model/alert_model.dart';
import 'package:donate/apps/map_app/presentation/controller/alert_controller.dart';
import 'package:donate/apps/map_app/presentation/controller/location_controller.dart';
import 'package:donate/apps/map_app/presentation/widgets/menu_widget.dart';
import 'package:donate/core/ui/widgets/custom_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/toolset/ui/custom_icons_icons.dart';
import '../../../auth/domain/model/position.dart';
import '../../../auth/presentation/controller/account_controller.dart';
import '../widgets/donation_info_window.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool menuOpened = false;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alerts = ref.watch(alertsProvider);
    final location = ref.watch(locationProvider);
    final account = ref.watch(accountRivProvider);

    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: ColoredBox(
            color: Colors.white,
            child: Stack(children: [
              _buildMap(alerts, location),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!menuOpened)
                      IconButton.filled(
                        onPressed: () {
                          setState(() {
                            menuOpened = true;
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          )),
                          iconSize: 36,
                        ),
                        icon: const Icon(
                          CustomIcons.menu,
                        ),
                      ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/account');
                        },
                        icon: account is AsyncData
                            ? MyCircleAvatar(
                                bloodType: account.value!.bloodType,
                                size: 60,
                              )
                            : const MyCircleAvatar(
                                bloodType: "...",
                                size: 60,
                              ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/list',
                      );
                    },
                    label: const Text('List View'),
                  ),
                ),
              ),
              if (menuOpened)
                FoldableMenu(onBackPressed: () {
                  setState(() {
                    menuOpened = false;
                  });
                })
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.invalidate(alertsProvider); // Refresh the alerts
          },
          child: const Icon(Icons.refresh)),
    );
  }

  Widget _buildMap(
      AsyncValue<List<Alert>> asyncAlerts, AsyncValue<Position> asyncLocation) {
    if (!Platform.isAndroid) {
      return const Text("This app is only available on Android");
    }
    if (asyncLocation is AsyncError || asyncAlerts is AsyncError) {
      debugPrint(asyncLocation.error.toString() + asyncAlerts.error.toString());
      return const Text("An error occured");
    } else if (asyncLocation is AsyncLoading || asyncAlerts is AsyncLoading) {
      return const CustomProgressIndicator();
    }

    final alertSet = asyncAlerts.value!.map((e) {
      final pos = LatLng(e.position.latitude, e.position.longitude);
      return Marker(
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              DonationInfoWindow(alert: e), pos);
        },
        markerId: const MarkerId('Your Location'),
        position: pos,
      );
    }).toSet();
    final location = asyncLocation.value!;

    return Stack(
      children: [
        GoogleMap(
          padding: const EdgeInsets.symmetric(vertical: 128),
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 11.0,
          ),
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller) async {
            _customInfoWindowController.googleMapController = controller;
          },
          markers: alertSet,
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 72,
          width: 144,
          offset: 50,
        ),
      ],
    );
  }
}
