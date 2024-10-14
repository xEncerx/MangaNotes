import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final bool value;
  final void Function(BuildContext, bool) onChanged;
  final IconData icon;
  final String title;

  const SettingsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: (value) => onChanged.call(context, value),
      ),
    );
  }
}
