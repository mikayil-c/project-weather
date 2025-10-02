import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final Icon leading;
  final String title;
  final String subtitle;
  final void Function() onTap;
  const SettingsItem({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}
