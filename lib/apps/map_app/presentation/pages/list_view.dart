import 'package:donate/apps/map_app/presentation/controller/alert_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/alert_model.dart';

class ListAlertsPage extends ConsumerWidget {
  const ListAlertsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View'),
      ),
      body: _buildList(ref.watch(alertsProvider)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Adding new alert');
          ref.read(alertsProvider.notifier).addAlert();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(AsyncValue<List<Alert>> asyncValue) {
    return asyncValue.when(
        data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  Text("${data[index].description}"),
            ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
