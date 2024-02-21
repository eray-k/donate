import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RequirementsWatcher extends StatefulWidget {
  const RequirementsWatcher({super.key, required this.child});
  final Widget child;

  @override
  State<RequirementsWatcher> createState() => _RequirementsWatcherState();
}

class _RequirementsWatcherState extends State<RequirementsWatcher> {
  late final StreamSubscription subsLocService, subsConnService;
  bool dialogShownLocStatus = false, dialogShownConnStatus = false;
  bool isReady = true;
  @override
  void initState() {
    subsLocService =
        Geolocator.getServiceStatusStream().listen((ServiceStatus result) {
      if (result == ServiceStatus.disabled) {
        dialogShownLocStatus = true;
        isReady = false;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.location_off),
              title: const Text('Location is disabled'),
              content: const Text(
                'Please enable location services',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Geolocator.openLocationSettings();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (dialogShownLocStatus) {
        Navigator.pop(context);
        dialogShownLocStatus = false;
      }
    });

    Geolocator.checkPermission().then(checkPerm);
    subsConnService = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        dialogShownConnStatus = true;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const AlertDialog(
              icon: Icon(Icons.wifi_off),
              title: Text('No internet connection'),
              content: Text(
                'Please check your internet connection',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      } else if (dialogShownConnStatus) {
        Navigator.pop(context);
        dialogShownConnStatus = false;
      }
    });
    super.initState();
  }

  void checkPerm(LocationPermission result) {
    debugPrint('Location permission status: $result');
    isReady = true;
    if (result == LocationPermission.denied ||
        result == LocationPermission.deniedForever) {
      isReady = false;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.location_off),
            title: const Text('Location permission is denied'),
            content: const Text(
              'This app needs location permission to function properly',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Geolocator.requestPermission().then((value) async =>
                      checkPerm(await Geolocator.checkPermission()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    subsLocService.cancel();
    subsConnService.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isReady
        ? widget.child
        : const Scaffold(
            body: ColoredBox(
            color: Colors.white,
          ));
  }
}
