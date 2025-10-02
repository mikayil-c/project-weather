import 'package:project_weather/app/constants/hive_constants.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'location_model.g.dart';

@HiveType(typeId: HiveConstants.locationTypeId)
class LocationModel extends HiveObject {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lon;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String state;
  @HiveField(4)
  final String country;
  @HiveField(5)
  final double timezone;

  LocationModel({
    required this.lat,
    required this.lon,
    required this.name,
    required this.state,
    required this.country,
    double? timezone,
  }) : timezone = ParseHelper.parseDouble(timezone);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: ParseHelper.parseDouble(json['lat']),
      lon: ParseHelper.parseDouble(json['lon']),
      name: json['address']['city'] ?? json['name'],
      state:
          json['address']['state'] ??
          json['address']['province'] ??
          json['address']['region'] ??
          '<state>',
      country: json['address']['country'] ?? '<country>',
    );
  }

  String get uniqueKey {
    final namePart = name.toLowerCase().replaceAll(' ', '-');
    final countryPart = country.toLowerCase().replaceAll(' ', '-');

    if (state.isNotEmpty) {
      final statePart = state.toLowerCase().replaceAll(' ', '-');
      return '$namePart-$statePart-$countryPart';
    }
    return '$namePart-$countryPart';
  }

  @override
  String toString() {
    return 'LocationModel(city: $name, state: $state, country: $country, lat: $lat, lon: $lon, timezone: $timezone,uniqueKey: $uniqueKey)';
  }
}
