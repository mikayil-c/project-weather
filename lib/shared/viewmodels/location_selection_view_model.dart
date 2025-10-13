import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/duration_constants.dart';
import 'package:project_weather/models/model/location_model.dart';
import 'package:project_weather/models/state/location_selection_state.dart';
import 'package:project_weather/shared/providers/location_provider.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/shared/services/location_service.dart';
import 'package:project_weather/shared/services/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationSelectionViewModelProvider =
    AsyncNotifierProvider<LocationSelectionViewModel, LocationSelectionState>(
      () {
        return LocationSelectionViewModel();
      },
    );

class LocationSelectionViewModel extends AsyncNotifier<LocationSelectionState> {
  LocationService get _locationService => ref.read(locationServiceProvider);
  NetworkService get _networkService => ref.read(networkServiceProvider);

  StreamSubscription? _searchSubscription;

  @override
  FutureOr<LocationSelectionState> build() async {
    debugPrint('Started <LocationSelectionViewModel>build()');
    ref.onDispose(() {
      _searchSubscription?.cancel();
    });

    return LocationSelectionState();
  }

  Future<void> searchLocations(String query) async {
    try {
      debugPrint('searchLocations() method started.');
      await _searchSubscription?.cancel();
      final current = state.valueOrNull ?? LocationSelectionState();

      final isConnected = await _isConnected();
      if (!isConnected) {
        state = AsyncValue.data(current.copyWith(hasInternet: false));
        return;
      }

      _clearList();
      if (!_isQueryValid(query)) return;

      state = const AsyncValue.loading();

      final completer = Completer<List<LocationModel>>();

      _locationService.debouncedSearchLocations(query.trim(), (list) {
        if (!completer.isCompleted) {
          completer.complete(list);
        }
      });

      final results = await completer.future.timeout(
        DurationConstants.locationSearchTtl,
        onTimeout: () {
          return [];
        },
      );

      state = AsyncValue.data(
        current.copyWith(locations: results, hasInternet: true),
      );
    } catch (e, st) {
      debugPrint('Error searching locations. ${e.toString()}');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> selectLocation(LocationModel loc) async {
    try {
      debugPrint('selectLocation() method started.');
      await ref.read(locationNotifierProvider.notifier).addLocation(loc);
    } catch (e) {
      debugPrint('Error selecting location: $e');
      rethrow;
    }
  }

  Future<bool> _isConnected() async {
    return _networkService.isConnected;
  }

  Future<void> _clearList() async {
    debugPrint('_clearList() method started.');
    final current = state.valueOrNull ?? LocationSelectionState();
    state = AsyncValue.data(
      current.copyWith(locations: const [], hasInternet: true),
    );
  }

  bool _isQueryValid(String query) {
    debugPrint('_isQueryValid() method started.');
    return query.trim().length > 2;
  }
}
