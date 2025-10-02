import 'package:project_weather/models/model/location_model.dart';

class LocationSelectionState {
  LocationSelectionState({this.locations = const [], this.hasInternet = true});

  final List<LocationModel> locations;
  final bool hasInternet;

  LocationSelectionState copyWith({
    List<LocationModel>? locations,
    bool? hasInternet,
  }) {
    return LocationSelectionState(
      locations: locations ?? this.locations,
      hasInternet: hasInternet ?? this.hasInternet,
    );
  }
}
