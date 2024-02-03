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
    return GestureDetector(
      onTap: () {
        debugPrint('Tapped on alert');
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4.0, right: 4.0),
                child: ColoredBox(
                    color: Colors
                        .red, //TODO: Change color according to criticality
                    child: SizedBox(width: 4, height: 28)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                    Text(alert.bloodType,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                    Text(timeAgoSinceDate(alert.position.timestamp!),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.44),
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
