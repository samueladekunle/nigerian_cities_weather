import 'package:weather/src/features/weather/models/city.dart';
import 'package:weather/src/features/weather/models/weather.dart';

typedef CityWeatherList = List<CityWeather>;

class CityWeather {
  const CityWeather({
    required this.city,
    required this.weather,
  });

  final City city;
  final Weather weather;
}
