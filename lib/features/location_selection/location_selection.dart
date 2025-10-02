import 'package:flutter/material.dart';
import 'package:project_weather/features/location_selection/widgets/search_info.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/shared/widgets/error_screen.dart';
import 'package:project_weather/shared/viewmodels/location_selection_view_model.dart';
import 'package:project_weather/features/location_selection/widgets/locations_data.dart';
import 'package:project_weather/features/location_selection/widgets/locations_loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationSelection extends ConsumerStatefulWidget {
  const LocationSelection({super.key});

  @override
  ConsumerState<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends ConsumerState<LocationSelection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationSelectionState = ref.watch(
      locationSelectionViewModelProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectLocation),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: ref
                  .read(locationSelectionViewModelProvider.notifier)
                  .searchLocations,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.locSelectHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),

          Expanded(
            child: locationSelectionState.when(
              data: (state) {
                final searchText = _searchController.text.trim();

                if (!state.hasInternet) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.signal_wifi_connected_no_internet_4_rounded,
                            ),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.somethingWrongWithInternet,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // action is not active because i didnt fix overflow problem yet.

                        // action: SnackBarAction(
                        //   label: AppLocalizations.of(context)!.tryAgain,
                        //   onPressed: () => ref
                        //       .read(locationSelectionViewModelProvider.notifier)
                        //       .searchLocations(_searchController.text),
                        // ),
                      ),
                    );
                  });
                }

                if (searchText.isEmpty) {
                  return SearchInfo(
                    text: AppLocalizations.of(context)!.locSelectEnterName,
                  );
                }

                if (searchText.length <= 2) {
                  return SearchInfo(
                    text: AppLocalizations.of(
                      context,
                    )!.pleaseEnterMoreThanTwoChar,
                  );
                }

                return LocationsData(
                  list: state.locations,
                  onTap: (loc) async => await ref
                      .read(locationSelectionViewModelProvider.notifier)
                      .selectLocation(loc),
                );
              },
              error: (error, stackTrace) {
                return ErrorScreen(
                  message: error.toString(),
                  additionalActions: [
                    ElevatedButton(
                      onPressed: () {
                        if (_searchController.text.trim().isNotEmpty) {
                          ref
                              .read(locationSelectionViewModelProvider.notifier)
                              .searchLocations(_searchController.text);
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.tryAgain),
                    ),
                  ],
                );
              },
              loading: () {
                return LocationsLoading(
                  localizations: AppLocalizations.of(context)!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
