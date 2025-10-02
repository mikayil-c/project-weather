import 'package:flutter/material.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/features/weather/weather.dart';

class LocationsData extends StatelessWidget {
  final List<LocationModel> list;
  final Future<void> Function(LocationModel loc) onTap;

  const LocationsData({super.key, required this.list, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final location = list[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(
              location.name,
              style: TextTheme.of(context).titleMedium,
            ),
            subtitle: Text('${location.state} - ${location.country}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await onTap(location);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Weather()),
              );
            },
          ),
        );
      },
    );
  }
}
