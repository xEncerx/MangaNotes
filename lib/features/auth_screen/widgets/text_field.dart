import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool usePasswordValidator;
  final bool obscureText;
  final Widget? suffix;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.usePasswordValidator = false,
    this.obscureText = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffix,
        labelText: labelText,
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
      validator: (value) => _valueValidator(value),
    );
  }

  String? _valueValidator(String? value) {
    if (value == null || value.isEmpty) return "Введите значение";
    if (usePasswordValidator && value.length < 6) {
      return "Пароль должен содержать хоты бы 6 знаков";
    }

    return null;
  }
}
