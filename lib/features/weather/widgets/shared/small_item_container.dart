import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';
import 'package:project_weather/features/weather/widgets/shared/percent_icon.dart';
import 'package:project_weather/features/weather/widgets/shared/small_info_popup.dart';

class SmallItemContainer extends StatelessWidget {
  const SmallItemContainer({
    super.key,
    required this.title,
    required this.text,
    required this.value,
    required this.info,
    required this.icon,
    required this.percentage,
  });

  final String title;
  final String text;
  final String value;
  final String info;
  final IconData icon;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextConstants.infoWidgetTitle),
                  Text(text, style: TextConstants.infoWidgetText),
                ],
              ),
              SmallInfoPopup(text: info),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PercentIcon(icon: icon, percentage: percentage),
                Text(value, style: TextConstants.infoWidgetValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
