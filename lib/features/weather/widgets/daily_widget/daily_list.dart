import 'package:flutter/material.dart';
import 'package:project_weather/l10n/app_localizations.dart';
import 'package:project_weather/models/model/daily_forecast_packet.dart';
import 'package:project_weather/features/weather/widgets/daily_widget/daily_forecast_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DailyList extends ConsumerWidget {
  final DailyForecastPacket packet;

  const DailyList({super.key, required this.packet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    if (packet.list.isEmpty) {
      return Center(child: Text(localizations.daysNotAppeared));
    }

    final pageController = PageController();

    return Column(
      children: [
        SizedBox(
          height: 420,
          child: PageView.builder(
            controller: pageController,
            itemCount: (packet.list.length / 7).ceil(),
            onPageChanged: (index) {},
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 7;
              final endIndex = (startIndex + 7 < packet.list.length)
                  ? startIndex + 7
                  : packet.list.length;

              final pageItems = packet.list.sublist(startIndex, endIndex);

              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 60,
                ),
                itemCount: pageItems.length,
                itemBuilder: (context, index) {
                  return DailyForecastItem(dayData: pageItems[index]);
                },
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: (packet.list.length / 10).ceil(),
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.white,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
