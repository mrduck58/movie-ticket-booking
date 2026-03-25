import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final genders = ["Nam", "Nữ", "Chưa cập nhật"];

    return DropdownButtonFormField<String>(
      initialValue: value,
      items: genders
          .map((g) => DropdownMenuItem(
                value: g,
                child: Text(g),
              ))
          .toList(),
      onChanged: (v) => onChanged(v!),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}