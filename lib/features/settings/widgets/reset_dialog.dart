import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/features/intro/intro.dart';

class ResetDialog extends StatelessWidget {
  final AppLocalizations localizations;
  final Future<void> Function() onClear;

  const ResetDialog({
    super.key,
    required this.localizations,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(localizations.resetAllData),
      content: Text(localizations.thisWillClearAllData),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localizations.cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            await onClear();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Intro()),
            );
          },
          child: Text(localizations.clear),
        ),
      ],
    );
  }
}
