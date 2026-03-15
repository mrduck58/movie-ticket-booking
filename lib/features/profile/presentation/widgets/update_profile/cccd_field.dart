import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CccdField extends StatelessWidget {

  final TextEditingController controller;

  const CccdField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,

      keyboardType: TextInputType.number,

      maxLength: 12,

      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],

      decoration: InputDecoration(
        labelText: "Căn cước công dân",
        prefixIcon: const Icon(Icons.badge_outlined),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        counterText: "", // ẩn 0/12
      ),

      validator: (value) {

        if (value == null || value.isEmpty) {
          return "CCCD không được để trống";
        }

        if (value.length != 12) {
          return "CCCD phải gồm 12 chữ số";
        }

        return null;
      },
    );
  }
}