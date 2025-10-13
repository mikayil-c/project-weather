import 'package:flutter/material.dart';
import 'package:project_weather/features/settings/widgets/reset_dialog.dart';
import 'package:project_weather/l10n/app_localizations.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, required this.onClear});

  final Future<void> Function() onClear;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.red,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
      ),
      child: Text(
        AppLocalizations.of(context)!.resetAllData,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => ResetDialog(
            localizations: AppLocalizations.of(context)!,
            onClear: onClear,
          ),
        );
      },
    );
  }
}
