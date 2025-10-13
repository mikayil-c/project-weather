import 'package:project_weather/models/model/location_model.dart';

class LocationState {
  final List<LocationModel> savedLocations;
  final LocationModel? location;

  LocationState({this.savedLocations = const [], this.location});

  LocationState copyWith({
    List<LocationModel>? savedLocations,
    LocationModel? location,
  }) {
    return LocationState(
      savedLocations: savedLocations ?? this.savedLocations,
      location: location ?? this.location,
    );
  }
}
