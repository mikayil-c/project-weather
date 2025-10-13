import 'dart:async';

import 'package:dio/dio.dart';
import 'package:project_weather/app/constants/duration_constants.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final Dio _dio = Dio();
  Timer? _timer;

  void debouncedSearchLocations(
    String query,
    Function(List<LocationModel>) onResult,
  ) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(DurationConstants.locationSearchDebounceTtl, () async {
      final results = await searchLocations(query);
      onResult(results);
    });
  }

  Future<List<LocationModel>> searchLocations(String value) async {
    try {
      final url =
          '${dotenv.env['NOM_BASE_URL']}/search?q=$value&format=json&limit=10&addressdetails=1&featureType=city';

      final response = await _dio.get(
        url,
        options: Options(headers: {'User-Agent': 'Flutter City Search App'}),
      );

      final List<dynamic> data = response.data;

      return data.map((item) => LocationModel.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<LocationModel> getLocationFromCoord(double lat, double lon) async {
    try {
      final url =
          '${dotenv.env['NOM_BASE_URL']}/search?q=$lat,$lon&format=json&limit=1&addressdetails=1&featureType=city';

      final response = await _dio.get(
        url,
        options: Options(headers: {'User-Agent': 'Project W'}),
      );

      final List<dynamic> data = response.data;

      return LocationModel.fromJson(data[0]);
    } catch (e) {
      throw Exception();
    }
  }

  Future<Position> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('LocationModel service is closed');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('LocationModel permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'LocationModel permissions are permanently denied, enable them in settings.',
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      ),
    );
  }
}
