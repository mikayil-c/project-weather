import 'package:flutter/material.dart';
import 'package:project_weather/app/constants/text_constants.dart';
import 'package:project_weather/features/weather/widgets/shared/item_container.dart';

class MediumItemContainer extends StatelessWidget {
  const MediumItemContainer({
    super.key,
    required this.title,
    required this.value,
    required this.text,
    required this.widget,
  });

  final String title;
  final String value;
  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        spacing: 12.0,
        children: [
          Expanded(flex: 2, child: widget),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextConstants.infoWidgetTitle),
                Text(value, style: TextConstants.infoWidgetValue),
                Text(text, style: TextConstants.infoWidgetText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
