import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_az.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('az'),
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('ru'),
    Locale('tr'),
  ];

  /// Text shown on app startup when loading
  ///
  /// In en, this message translates to:
  /// **'Looking to the sky...'**
  String get lookingToSky;

  /// Error title displayed on app startup
  ///
  /// In en, this message translates to:
  /// **'Starting feels wrong...'**
  String get startingFeelsWrong;

  /// Error text displayed on no internet connection
  ///
  /// In en, this message translates to:
  /// **'There is something wrong with internet...'**
  String get somethingWrongWithInternet;

  /// Error message displayed on app startup
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get pleaseTryAgain;

  /// Information text about location selection
  ///
  /// In en, this message translates to:
  /// **'To start the app select a location or allow us to find your location'**
  String get introDetail;

  /// Button text for selecting a location
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get introSelectButton;

  /// Button text for automatically finding the user's location
  ///
  /// In en, this message translates to:
  /// **'Automate my location'**
  String get introFindButton;

  /// Hint text in the location search field
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get locSelectHint;

  /// Text shown when search input is less than 2 characters
  ///
  /// In en, this message translates to:
  /// **'Enter a location name'**
  String get locSelectEnterName;

  /// Text shown when no locations match the search
  ///
  /// In en, this message translates to:
  /// **'No locations found'**
  String get locSelectNoLocations;

  /// Text shown while searching for locations
  ///
  /// In en, this message translates to:
  /// **'Getting infos from birds...'**
  String get locSelectGettingInfos;

  /// Label for settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for selecting a location
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocation;

  /// Generic 'try again' text used in various places
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Message shown when there are no saved locations
  ///
  /// In en, this message translates to:
  /// **'No saved location'**
  String get noSavedLocations;

  /// Label for latest data
  ///
  /// In en, this message translates to:
  /// **'latest'**
  String get latest;

  /// Label for feels-like temperature
  ///
  /// In en, this message translates to:
  /// **'feels like'**
  String get feelsLike;

  /// Error text shown when daily forecast is missing (corrected spelling)
  ///
  /// In en, this message translates to:
  /// **'Oops. Days not appeared :('**
  String get daysNotAppeared;

  /// Short for North direction
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get northLetter;

  /// Short for South direction
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get southLetter;

  /// Short for West direction
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get westLetter;

  /// Short for East direction
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get eastLetter;

  /// Label for wind information
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// Measurement unit label
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// Button to reset all stored app data
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get resetAllData;

  /// Instruction to choose a measurement unit
  ///
  /// In en, this message translates to:
  /// **'Select a unit'**
  String get selectUnit;

  /// Confirmation button text (standardized capitalization)
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Warning message before clearing all app data
  ///
  /// In en, this message translates to:
  /// **'This will clear all data(including locations) and navigate to intro page.'**
  String get thisWillClearAllData;

  /// Weather condition: heavy fog
  ///
  /// In en, this message translates to:
  /// **'Heavy fog'**
  String get heavyFog;

  /// Weather condition: fog
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get fog;

  /// Visibility condition: very low (less than 1km)
  ///
  /// In en, this message translates to:
  /// **'Very low visibility'**
  String get veryLowVisibility;

  /// Visibility condition: low (1-4km)
  ///
  /// In en, this message translates to:
  /// **'Low visibility'**
  String get lowVisibility;

  /// General label for limited status
  ///
  /// In en, this message translates to:
  /// **'Limited visibility'**
  String get limited;

  /// General label for medium level
  ///
  /// In en, this message translates to:
  /// **'Medium visibility'**
  String get medium;

  /// Visibility condition: very clear
  ///
  /// In en, this message translates to:
  /// **'Very clear visibility'**
  String get veryClear;

  /// Safety warning for heavy fog conditions with specific distance
  ///
  /// In en, this message translates to:
  /// **'Visibility less than 50m - driving is dangerous'**
  String get heavyFogInfo;

  /// Safety warning for fog conditions with specific distance
  ///
  /// In en, this message translates to:
  /// **'Visibility up to 200m - be careful while driving'**
  String get fogInfo;

  /// Information for vision about very low visibility effects
  ///
  /// In en, this message translates to:
  /// **'Fog or heavy rain'**
  String get veryLowVisibilityInfo;

  /// Information for vision about low visibility effects (removed extra space)
  ///
  /// In en, this message translates to:
  /// **'Light fog or rain'**
  String get lowVisibilityInfo;

  /// Information for vision about limited visibility effects
  ///
  /// In en, this message translates to:
  /// **'Hazy weather'**
  String get limitedInfo;

  /// Information about medium visibility conditions
  ///
  /// In en, this message translates to:
  /// **'Medium visibility up to 20km, slightly cloudy'**
  String get mediumVisibilityInfo;

  /// Information about clear visibility conditions
  ///
  /// In en, this message translates to:
  /// **'Good visibility up to 40km, clear weather'**
  String get clearInfo;

  /// Information for vision about very clear visibility effects
  ///
  /// In en, this message translates to:
  /// **'Everything is fine'**
  String get veryClearInfo;

  /// Humidity condition: low
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get lowHum;

  /// Humidity condition: medium
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get mediumHum;

  /// Humidity condition: high
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get highHum;

  /// Humidity condition: very high
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get veryHighHum;

  /// Health information about low humidity effects
  ///
  /// In en, this message translates to:
  /// **'Dry air may cause skin and throat dryness'**
  String get lowHumidityInfo;

  /// Comfort information about medium humidity levels
  ///
  /// In en, this message translates to:
  /// **'Comfortable humidity range for most people'**
  String get mediumHumidityInfo;

  /// Comfort information about high humidity effects
  ///
  /// In en, this message translates to:
  /// **'High humidity may cause discomfort and reduced sweat evaporation'**
  String get highHumidityInfo;

  /// Health warning about very high humidity levels
  ///
  /// In en, this message translates to:
  /// **'Very uncomfortable, potentially unhealthy conditions'**
  String get veryHighHumidityInfo;

  /// Atmospheric pressure condition: very low (storm conditions)
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get veryLowPressure;

  /// Atmospheric pressure condition: low (rainy weather)
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get lowPressure;

  /// Atmospheric pressure condition: medium (variable weather)
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get mediumPressure;

  /// Atmospheric pressure condition: high (clear weather)
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get highPressure;

  /// Atmospheric pressure condition: very high (very clear weather)
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get veryHighPressure;

  /// Information about very low pressure effects
  ///
  /// In en, this message translates to:
  /// **'Storms and severe weather conditions are expected'**
  String get veryLowPressureInfo;

  /// Information about low pressure effects
  ///
  /// In en, this message translates to:
  /// **'Rainy and cloudy weather is possible'**
  String get lowPressureInfo;

  /// Information about medium pressure effects
  ///
  /// In en, this message translates to:
  /// **'Mixed weather conditions may vary'**
  String get mediumPressureInfo;

  /// Information about high pressure effects
  ///
  /// In en, this message translates to:
  /// **'Clear and sunny weather is expected'**
  String get highPressureInfo;

  /// Information about very high pressure effects
  ///
  /// In en, this message translates to:
  /// **'Very clear and calm weather conditions'**
  String get veryHighPressureInfo;

  /// Unit system: Standard
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standart;

  /// Unit system: Metric
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metric;

  /// Unit system: Imperial
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperial;

  /// Wind condition: calm
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calmWind;

  /// Wind condition: light breeze
  ///
  /// In en, this message translates to:
  /// **'Light breeze'**
  String get lightBreezeWind;

  /// Wind condition: gentle breeze
  ///
  /// In en, this message translates to:
  /// **'Gentle breeze'**
  String get gentleBreezeWind;

  /// Wind condition: moderate breeze
  ///
  /// In en, this message translates to:
  /// **'Moderate breeze'**
  String get moderateBreezeWind;

  /// Wind condition: strong breeze
  ///
  /// In en, this message translates to:
  /// **'Strong breeze'**
  String get strongBreezeWind;

  /// Wind condition: gale
  ///
  /// In en, this message translates to:
  /// **'Gale'**
  String get galeWind;

  /// Wind condition: storm
  ///
  /// In en, this message translates to:
  /// **'Storm'**
  String get stormWind;

  /// Information about calm wind
  ///
  /// In en, this message translates to:
  /// **'Not a leaf is moving'**
  String get calmWindInfo;

  /// Information about light breeze wind
  ///
  /// In en, this message translates to:
  /// **'Leaves are swaying'**
  String get lightBreezeWindInfo;

  /// Information about gentle breeze wind
  ///
  /// In en, this message translates to:
  /// **'Branches and small trees are swaying'**
  String get gentleBreezeWindInfo;

  /// Information about moderate breeze wind
  ///
  /// In en, this message translates to:
  /// **'Big trees are swaying'**
  String get moderateBreezeWindInfo;

  /// Information about strong breeze wind
  ///
  /// In en, this message translates to:
  /// **'Trees are bending'**
  String get strongBreezeWindInfo;

  /// Information about gale wind
  ///
  /// In en, this message translates to:
  /// **'It is hard to walk outside'**
  String get galeWindInfo;

  /// Information about storm wind
  ///
  /// In en, this message translates to:
  /// **'Dangerous wind'**
  String get stormWindInfo;

  /// Error message when saving locations fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save locations'**
  String get failedToSaveLoc;

  /// Error message when saving weather data fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save weather'**
  String get failedToSaveWeather;

  /// Error message when saving daily forecast fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save daily forecast'**
  String get failedToSaveDaily;

  /// Error message when saving hourly forecast fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save hourly forecast'**
  String get failedToSaveHourly;

  /// Error message when location service is closed
  ///
  /// In en, this message translates to:
  /// **'LocationModel service is closed'**
  String get locModelServiceClosed;

  /// Error message when location permissions are denied
  ///
  /// In en, this message translates to:
  /// **'LocationModel permissions are denied'**
  String get permissionsDenied;

  /// Error message when location permissions are permanently denied
  ///
  /// In en, this message translates to:
  /// **'LocationModel permissions are permanently denied, enable them in settings'**
  String get permissionsPermanentlyBanned;

  /// Today text
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Monday text
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// Tuesday text
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// Wednesday text
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// Thursday text
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// Friday text
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// Saturday text
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// Sunday text
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// January text
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// February text
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// March text
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// April text
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// May text
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// June text
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// July text
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// August text
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// September text
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// October text
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// November text
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// December text
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// Language text
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Select a language text
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get selectLanguage;

  /// Snackbar text while automate user's location
  ///
  /// In en, this message translates to:
  /// **'Detecting location...'**
  String get detectingLocation;

  /// Location detected text
  ///
  /// In en, this message translates to:
  /// **'Location detected'**
  String get locationDetected;

  /// Location detection timed out text
  ///
  /// In en, this message translates to:
  /// **'Location detection timed out'**
  String get locationDetectionTimedOut;

  /// Location permission denied text
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// Location service is disabled text
  ///
  /// In en, this message translates to:
  /// **'Location service is disabled'**
  String get locationServiceIsDisabled;

  /// Failed to detect location text
  ///
  /// In en, this message translates to:
  /// **'Failed to detect location'**
  String get failedToDetectLocation;

  /// Retry text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Please enter more than 2 characters text
  ///
  /// In en, this message translates to:
  /// **'Please enter more than 2 characters'**
  String get pleaseEnterMoreThanTwoChar;

  /// Pressure text
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// Humidity text
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'az',
    'de',
    'en',
    'fr',
    'ru',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'az':
      return AppLocalizationsAz();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
