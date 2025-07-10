import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool isConfirmPassword;
  final String? passwordToMatch;

  const PasswordField({
    super.key,
    required this.controller,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
    this.validator,
    this.onChanged,
    this.isConfirmPassword = false,
    this.passwordToMatch,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isPasswordVisible,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: widget.isConfirmPassword
          ? (value) => Validators.validatePasswordMatch(widget.passwordToMatch, value)
          : widget.validator ?? Validators.validatePassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
              debugPrint('Password visibility toggled: $_isPasswordVisible');
            });
          },
        ),
      ),
      onChanged: widget.onChanged,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}