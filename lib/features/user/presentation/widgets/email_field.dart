import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const EmailField({
    super.key,
    required this.controller,
    this.labelText = 'Email',
    this.hintText = 'Enter your email',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: Validators.validateEmail,
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