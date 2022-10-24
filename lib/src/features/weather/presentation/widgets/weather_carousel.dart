import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/features/weather/models/city_weather.dart';
import 'package:weather/src/features/weather/presentation/widgets/weather_carousel_card.dart';

class WeatherCarousel extends StatelessWidget {
  const WeatherCarousel({
    super.key,
    required this.weatherList,
  });

  final CityWeatherList weatherList;

  @override
  Widget build(BuildContext context) {
    if (weatherList.isEmpty) {
      return Center(
        child: Text(
          context.localization.emptyFavouriteCitiesText,
          style: context.textTheme.headline6?.copyWith(height: 2),
          textAlign: TextAlign.center,
        ),
      );
    }
    return CarouselSlider(
      items:
          weatherList.map((e) => WeatherCarouselCard(cityWeather: e)).toList(),
      options: CarouselOptions(
        height: 400,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }
}
