import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const UsernameField({
    super.key,
    required this.controller,
    this.labelText = 'Username',
    this.hintText = 'Enter your username',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: Validators.validateUsername,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}