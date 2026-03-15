import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameField extends StatelessWidget {

  final TextEditingController controller;

  const NameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,

      textCapitalization: TextCapitalization.words,

      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r"[a-zA-ZÀ-ỹ\s]"),
        ),
      ],

      decoration: InputDecoration(
        labelText: "Họ và tên",
        prefixIcon: const Icon(Icons.person_outline),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      validator: (value) {

        if (value == null || value.trim().isEmpty) {
          return "Tên không được để trống";
        }

        if (value.trim().length < 2) {
          return "Tên quá ngắn";
        }

        return null;
      },
    );
  }
}