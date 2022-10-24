import 'package:flutter/material.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/core/extensions/string_extensions.dart';
import 'package:weather/src/core/widgets/bottom_sheet_card.dart';
import 'package:weather/src/features/weather/models/weather.dart';
import 'package:weather/src/features/weather/presentation/widgets/weather_icon_image.dart';

class WeatherBottomSheetCard extends StatelessWidget {
  const WeatherBottomSheetCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return BottomSheetCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.localization.currentLocationWeather,
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherIconImage(
                iconUrl: weather.information.first.iconUrl,
                size: 100,
              ),
              Text(
                '${weather.temp.celsius.toInt()}°C',
                style: textTheme.headline2,
              ),
            ],
          ),
          Text(
            weather.information.first.description.capitalize(),
            style: textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
