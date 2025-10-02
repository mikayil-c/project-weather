import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project_weather/app/constants/duration_constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _checker = InternetConnectionChecker();

  final StreamController<bool> _controller = StreamController.broadcast();

  NetworkService() {
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final result = _getResult(results);
      _updateStatus(result);
    });
    _init();
  }

  void _init() async {
    final results = await _connectivity.checkConnectivity();
    final result = _getResult(results);
    await _updateStatus(result);
  }

  Future<void> _updateStatus(ConnectivityResult result) async {
    try {
      bool hasInternet = false;
      if (result != ConnectivityResult.none) {
        hasInternet = await _checker.hasConnection;
      }
      _controller.add(hasInternet);
    } catch (e) {
      _controller.add(false);
    }
  }

  Stream<bool> get onStatusChanged => _controller.stream;

  // getter method for use in weather or location service
  Future<bool> get isConnected async {
    try {
      final results = await _connectivity.checkConnectivity();
      final result = _getResult(results);
      if (result == ConnectivityResult.none) return false;

      return await _checker.hasConnection.timeout(
        DurationConstants.networkTtl,
        onTimeout: () => false,
      );
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    _controller.close();
  }

  // if connectivity results list is not empty gets first result, if empty gets none
  ConnectivityResult _getResult(List<ConnectivityResult> results) {
    return results.isNotEmpty ? results.first : ConnectivityResult.none;
  }
}
