import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/model/alert_model.dart';

class AlertService {
  const AlertService();
  Future<List<Alert>> getAlerts() async {
    final docsQuery =
        await FirebaseFirestore.instance.collection('alerts').get();
    return docsQuery.docs.map((e) => Alert.fromDoc(e.data())).toList();
  }

  /// Returns the id of the new alert
  Future<String> newAlert(Alert alert) async {
    final doc = FirebaseFirestore.instance.collection('alerts').doc();
    await doc.set(alert.toDoc());
    return doc.id;
  }
}
