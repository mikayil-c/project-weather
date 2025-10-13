import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/l10n/l10n.dart';

class LocaleDialog extends StatelessWidget {
  final AppLocalizations localizations;
  final String currentCode;
  final ValueChanged<String> onUpdate;

  const LocaleDialog({
    super.key,
    required this.currentCode,
    required this.localizations,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(localizations.selectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: L10n.all.entries.map((entry) {
          return RadioListTile<String>(
            title: Text(entry.key),
            value: entry.value.languageCode,
            groupValue: currentCode,
            onChanged: (localeCode) {
              if (localeCode == null || localeCode == currentCode) return;
              onUpdate(localeCode);
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(localizations.ok),
        ),
      ],
    );
  }
}
