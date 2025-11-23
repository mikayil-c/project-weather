import 'package:flutter/material.dart';
import 'package:project_weather/features/location_selection/location_selection.dart';
import 'package:project_weather/features/settings/settings.dart';
import 'package:project_weather/features/weather/location_dropdown.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: const Color.fromRGBO(245, 245, 245, 1),
      title: const LocationDropdown(),
      centerTitle: true,
      leading: const SettingsButton(),
      actions: [const AddLocationButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Settings()),
        );
      },
      icon: const Icon((Icons.settings)),
    );
  }
}

class AddLocationButton extends StatelessWidget {
  const AddLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationSelection()),
        );
      },
      icon: const Icon(Icons.add_location_alt_outlined),
    );
  }
}
