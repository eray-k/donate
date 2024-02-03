import 'package:donate/apps/auth/domain/model/position.dart';
import 'package:donate/apps/map_app/data/service/remote/alert_service.dart';
import 'package:donate/apps/map_app/presentation/controller/alert_controller.dart';
import 'package:donate/apps/map_app/presentation/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../dependency_injection.dart';
import '../../domain/model/alert_model.dart';

class ListAlertsPage extends StatelessWidget {
  const ListAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(alertsProvider).when(
              data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final a = data[index];
                      final distanceInDesimeters =
                          (a.distanceFrom(ref.watch(locationProvider).value!) *
                                  100)
                              .round();
                      final distanceText = distanceInDesimeters >= 10
                          ? "${(distanceInDesimeters / 100).toStringAsFixed(1)} km"
                          : "${distanceInDesimeters * 10} m";
                      return ListTile(
                          leading: Text(a.criticality.toString()),
                          title: Text("${a.description} ($distanceText)"));
                    },
                  ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Adding new alert');
          sl<AlertService>().newAlert(Alert(
              bloodType: "A+",
              criticality: 1,
              description: "Lolz",
              position: Position(
                  latitude: 1, longitude: 1, timestamp: DateTime.now())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
