import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_weather/models/state/app_startup_state.dart';
import 'package:project_weather/shared/providers/service_providers.dart';
import 'package:project_weather/shared/services/cache_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStartupProvider =
    AsyncNotifierProvider<AppStartupNotifier, AppStartupState>(() {
      return AppStartupNotifier();
    });

class AppStartupNotifier extends AsyncNotifier<AppStartupState> {
  CacheService get _cacheService => ref.read(cacheServiceProvider);

  @override
  Future<AppStartupState> build() async {
    return await _initialStartupState();
  }

  Future<AppStartupState> _initialStartupState() async {
    try {
      final locations = await _cacheService.getSavedLocations() ?? [];
      return locations.isEmpty ? AppStartupState.intro : AppStartupState.home;
    } catch (e) {
      debugPrint('Error initializing startup state. ${e.toString()}');
      return AppStartupState.intro;
    }
  }

  Future<void> retryStartupCheck() async {
    try {
      state = const AsyncValue.loading();

      final startupState = await _initialStartupState();

      state = AsyncValue.data(startupState);
    } catch (e, stackTrace) {
      debugPrint('Error retrying startup check. ${e.toString()}');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // clears all locations and sets state to intro
  Future<void> resetToIntro() async {
    try {
      await _cacheService.clearSavedLocations();
      state = const AsyncValue.data(AppStartupState.intro);
    } catch (e) {
      debugPrint('Error resetting to intro. ${e.toString()}');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
