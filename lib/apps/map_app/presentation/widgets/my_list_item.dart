import 'package:flutter/material.dart';
import '../../domain/model/alert_model.dart';

class AlertListTile extends StatelessWidget {
  const AlertListTile({
    super.key,
    required this.alert,
    required this.distanceText,
  });
  final Alert alert;
  final String distanceText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(alert.criticality.toString()),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert.description,
                softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 1),
            Text(alert.bloodType),
          ],
        ),
        subtitle: Text(distanceText,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF4A95A5),
                fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.info_outline));
  }
}
