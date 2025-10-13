import 'package:flutter/material.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/state/location_state.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/shared/services/cache_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---------NOTIFIER---------
class LocationNotifier extends AsyncNotifier<LocationState> {
  CacheService get _cacheService => ref.read(cacheServiceProvider);

  @override
  Future<LocationState> build() async {
    return _loadLocationData();
  }

  Future<void> addLocation(LocationModel loc) async {
    try {
      debugPrint('addLocation() method starting');
      final currentState = state.valueOrNull ?? LocationState();
      final list = currentState.savedLocations;

      if (list.any((l) => l.uniqueKey == loc.uniqueKey)) return;

      final updatedList = <LocationModel>[loc, ...list];

      await _saveLocations(updatedList);

      debugPrint('Location successfully added. $loc');

      state = AsyncValue.data(
        LocationState(savedLocations: updatedList, location: updatedList.first),
      );
    } catch (e, stackTrace) {
      debugPrint('Location could not be added. $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> removeLocation(LocationModel loc) async {
    try {
      debugPrint('removeLocation() method starting');
      final currentState = state.valueOrNull ?? LocationState();

      final list = currentState.savedLocations;

      if (!list.any((l) => l.uniqueKey == loc.uniqueKey)) return;

      final updatedList = list
          .where((l) => l.uniqueKey != loc.uniqueKey)
          .toList();

      await _saveLocations(updatedList);

      state = AsyncValue.data(
        LocationState(savedLocations: updatedList, location: updatedList.first),
      );
    } catch (e, stackTrace) {
      debugPrint('Location could not be removed. $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> changeLocation(LocationModel loc) async {
    try {
      debugPrint('changeLocation() method starting');
      final currentState = state.valueOrNull ?? LocationState();

      if (currentState.location?.uniqueKey == loc.uniqueKey) return;

      final list = currentState.savedLocations;

      final filteredList = list
          .where((l) => l.uniqueKey != loc.uniqueKey)
          .toList();

      final updatedList = <LocationModel>[loc, ...filteredList];

      await _saveLocations(updatedList);

      state = AsyncValue.data(
        LocationState(savedLocations: updatedList, location: loc),
      );
    } catch (e, stackTrace) {
      debugPrint('Location could not be changed. $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> clearState() async {
    debugPrint('clearState() method starting');
    state = AsyncValue.data(LocationState());
    await _cacheService.clearSavedLocations();
  }

  Future<LocationState> _loadLocationData() async {
    try {
      debugPrint('_loadLocationData() method starting');
      final list = await _getLocations();
      final location = list.isNotEmpty ? list.first : null;

      return LocationState(savedLocations: list, location: location);
    } catch (e) {
      debugPrint('Could not load location data. $e');
      return LocationState();
    }
  }

  Future<List<LocationModel>> _getLocations() async {
    try {
      debugPrint('_getLocations() method starting');
      final list = await _cacheService.getSavedLocations();
      return list ?? [];
    } catch (e) {
      debugPrint('Could not get saved locations data. $e');
      return <LocationModel>[];
    }
  }

  Future<void> _saveLocations(List<LocationModel> list) async {
    try {
      debugPrint('_saveLocations() method starting');
      await _cacheService.saveSavedLocations(list);
    } catch (e) {
      debugPrint('Could not save locations. $e');
      rethrow;
    }
  }
}

// ---------PROVIDERS---------
final locationNotifierProvider =
    AsyncNotifierProvider<LocationNotifier, LocationState>(() {
      return LocationNotifier();
    });
