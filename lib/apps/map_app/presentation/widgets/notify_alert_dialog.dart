import 'package:donate/core/toolset/ui/ui_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/widgets/blood_type_dropdown.dart';
import '../../../auth/presentation/controller/account_controller.dart';
import '../controller/alert_controller.dart';

class NotifyAlertDialog extends ConsumerStatefulWidget {
  const NotifyAlertDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotifyAlertDialogState();
}

class _NotifyAlertDialogState extends ConsumerState<NotifyAlertDialog> {
  final _titleController = TextEditingController();
  String? selectedBloodType;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedBloodType ??= ref.read(accountRivProvider).value!.bloodType ?? "A+";
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: const Text('Donation Request'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            autofocus: true,
          ),
          verticalSpacer(16),
          Row(
            children: [
              const Expanded(child: Text("Blood Type: ")),
              BloodTypeDropdown(
                value: selectedBloodType,
                onChanged: (val) {
                  setState(() {
                    selectedBloodType = val ?? "A+";
                  });
                },
              ),
            ],
          ),
          DropdownButton(
              value: "a",
              items: const [
                DropdownMenuItem(
                  value: "a",
                  child: Text("Use current location"),
                ),
                DropdownMenuItem(value: "b", child: Text("")),
              ],
              onChanged: (value) {}),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _titleController.text.isNotEmpty
              ? () {
                  Navigator.pop(context, 'OK');
                  ref
                      .read(alertsProvider.notifier)
                      .addAlert(_titleController.text, selectedBloodType!);
                  ref.invalidate(alertsProvider);
                }
              : null,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
