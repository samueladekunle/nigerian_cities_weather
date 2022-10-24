import 'package:flutter/material.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/core/extensions/string_extensions.dart';
import 'package:weather/src/features/weather/models/city_weather.dart';
import 'package:weather/src/features/weather/presentation/widgets/weather_icon_image.dart';
import 'package:weather/src/themes/colors.dart';

class WeatherCarouselCard extends StatelessWidget {
  const WeatherCarouselCard({
    super.key,
    required this.cityWeather,
  });

  final CityWeather cityWeather;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return SizedBox(
      width: 300,
      child: Card(
        color: AppColors.rainBlueLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              WeatherIconImage(
                iconUrl: cityWeather.weather.information.first.iconUrl,
                // size: 200,
                size: 100,
              ),
              Text(
                '${cityWeather.weather.temp.celsius.toInt()}°C',
                style: textTheme.headline2,
              ),
              Text(
                cityWeather.weather.information.first.description.capitalize(),
                style: textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                cityWeather.city.name,
                style: textTheme.headline4,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
