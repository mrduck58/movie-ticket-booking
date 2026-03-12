import 'package:flutter/material.dart';

class BirthdayPicker extends StatelessWidget {
  final TextEditingController controller;

  const BirthdayPicker({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onTap: () async {

        final date = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (date != null) {
          controller.text =
              "${date.day}/${date.month}/${date.year}";
        }
      },
    );
  }
}