import 'package:donate/apps/map_app/domain/model/alert_model.dart';
import 'package:donate/apps/map_app/presentation/controller/alert_controller.dart';
import 'package:donate/apps/map_app/presentation/controller/location_controller.dart';
import 'package:donate/apps/map_app/presentation/widgets/my_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListAlertsPage extends ConsumerWidget {
  const ListAlertsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final alerts = ref.watch(alertsProvider);
    if (!location.hasValue) {
      debugPrint('Location is not available');
      return const Scaffold(
        body: Center(
          child: Text('Location is not available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
      ),
      body: alerts.when(
          data: (data) {
            List<AlertWithDistance> sortedAlerts =
                data.map((e) => AlertWithDistance(e, location.value!)).toList();
            sortedAlerts.sort(
                (a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));
            return ListView.builder(
              itemCount: data.isEmpty ? 0 : data.length * 2 - 1, // Add dividers
              itemBuilder: (context, index) {
                if (index.isOdd) return const Divider();
                final a = sortedAlerts[index ~/ 2];

                return AlertListTile(
                    alert: a, distanceText: a.toDistanceString());
              },
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Adding new alert');
          ref.read(alertsProvider.notifier).addAlert();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
