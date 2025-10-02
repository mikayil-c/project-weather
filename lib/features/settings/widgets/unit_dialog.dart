import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/models/model/unit_model.dart';

class UnitDialog extends StatelessWidget {
  final AppLocalizations localizations;
  final UnitModel selectedUnit;
  final ValueChanged<UnitModel> onChanged;

  const UnitDialog({
    super.key,
    required this.localizations,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final unitList = UnitModel.values;

    return AlertDialog(
      title: Text(localizations.selectUnit),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: unitList.map((unit) {
          return RadioListTile(
            title: Text(unit.getText(context)),
            value: unit,
            groupValue: selectedUnit,
            onChanged: (value) {
              if (value == null || value == selectedUnit) return;
              onChanged(value);
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(localizations.ok),
        ),
      ],
    );
  }
}
