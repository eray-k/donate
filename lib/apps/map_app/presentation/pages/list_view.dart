import 'package:flutter/material.dart';

class ListAlertsPage extends StatelessWidget {
  const ListAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List View'),
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Alert $index'),
                subtitle: Text('Description $index'),
                trailing: const Icon(Icons.arrow_forward),
              );
            }));
  }
}
