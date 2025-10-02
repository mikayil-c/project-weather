class DurationConstants {
  // -------------FRESH WEATHER DATA DURATIONS-------------
  static const weatherTtl = Duration(minutes: 15);
  static const hourlyTtl = Duration(hours: 1);
  static const dailyTtl = Duration(hours: 6);

  // -------------REQUEST NETWORK DURATIONS-------------
  static const networkTtl = Duration(seconds: 10);
  static const locationSearchTtl = Duration(seconds: 5);

  // -------------DEBOUNCE DURATIONS-------------
  static const locationSearchDebounceTtl = Duration(seconds: 1);
}
