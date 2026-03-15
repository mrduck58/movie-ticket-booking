import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailField extends StatelessWidget {

  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,

      keyboardType: TextInputType.emailAddress,

      textInputAction: TextInputAction.next,

      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r"\s")), // chặn space
      ],

      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email_outlined),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      validator: (value) {

        if (value == null || value.isEmpty) {
          return "Email không được để trống";
        }

        final emailRegex = RegExp(
          r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
        );

        if (!emailRegex.hasMatch(value)) {
          return "Email không hợp lệ";
        }

        return null;
      },

      onChanged: (value) {

        controller.value = controller.value.copyWith(
          text: value.toLowerCase(),
          selection: TextSelection.collapsed(
            offset: value.length,
          ),
        );
      },
    );
  }
}