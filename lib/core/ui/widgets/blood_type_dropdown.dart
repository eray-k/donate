import 'package:flutter/material.dart';

class BloodTypeDropdown extends StatelessWidget {
  const BloodTypeDropdown({super.key, this.value, this.onChanged});
  final String? value;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: value,
        items: const [
          DropdownMenuItem(value: 'A+', child: Text('A+')),
          DropdownMenuItem(value: 'A-', child: Text('A-')),
          DropdownMenuItem(value: 'B+', child: Text('B+')),
          DropdownMenuItem(value: 'B-', child: Text('B-')),
          DropdownMenuItem(value: 'AB+', child: Text('AB+')),
          DropdownMenuItem(value: 'AB-', child: Text('AB-')),
          DropdownMenuItem(value: '0+', child: Text('0+')),
          DropdownMenuItem(value: '0-', child: Text('0-')),
        ],
        onChanged: onChanged);
  }
}
