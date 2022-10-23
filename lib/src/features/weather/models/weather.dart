import 'package:weather/src/features/weather/models/open_weather_response.dart';
import 'package:weather/src/features/weather/models/temperature.dart';

typedef WeatherList = List<Weather>;

class Weather {
  const Weather({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.information,
  });

  factory Weather.fromOpenWeatherResponse(OpenWeatherResponse response) =>
      Weather(
        temp: Temperature.celsius(response.reading.temp),
        minTemp: Temperature.celsius(response.reading.minTemp),
        maxTemp: Temperature.celsius(response.reading.maxTemp),
        information: response.weatherInfo,
      );

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final List<WeatherInfo> information;
}
