import 'package:donate/core/theme/criticality_levels.dart';
import 'package:flutter/material.dart';

import '../../../../core/toolset/time_difference.dart';
import '../../domain/model/alert_model.dart';

class DonationInfoWindow extends StatelessWidget {
  const DonationInfoWindow({
    super.key,
    required this.alert,
  });
  final Alert alert;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        height: 80,
        width: 200,
        child: Container(
            //padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: ColoredBox(
                      color: criticalityColors[alert.criticality] ?? Colors.red,
                      child: const SizedBox(width: 170, height: 4)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(alert.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            Text(timeAgoSinceDate(alert.position.timestamp!),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.44),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(alert.bloodType,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
