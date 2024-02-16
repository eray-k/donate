import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityWatcher extends StatefulWidget {
  const ConnectivityWatcher({super.key, required this.child});
  final Widget child;

  @override
  State<ConnectivityWatcher> createState() => _ConnectivityWatcherState();
}

class _ConnectivityWatcherState extends State<ConnectivityWatcher> {
  late final StreamSubscription subscription;
  bool dialogShown = false;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        dialogShown = true;
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
      } else if (dialogShown) {
        Navigator.pop(context);
        dialogShown = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
