import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPasswordField;
  final Widget? suffix;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.suffix,
    this.isPasswordField = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isPasswordField)
              IconButton(
                onPressed: () => _changeObscure(),
                icon: _obscureText
                    ? Icon(
                        Icons.visibility_off_outlined,
                        color: theme.primaryColor,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        color: theme.primaryColor,
                      ),
              ),
            if (widget.suffix != null) widget.suffix!,
          ],
        ),
        labelText: widget.labelText,
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          color: Colors.redAccent,
        ),
      ),
      validator: (value) => _valueValidator(value),
    );
  }

  String? _valueValidator(String? value) {
    if (value == null || value.isEmpty) return "Введите значение";
    if (widget.isPasswordField && value.length < 6) {
      return "Пароль должен содержать хоты бы 6 знаков";
    }

    return null;
  }

  void _changeObscure() => setState(() => _obscureText = !_obscureText);
}
