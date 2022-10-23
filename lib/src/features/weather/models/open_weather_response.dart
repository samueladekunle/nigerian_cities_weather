import 'package:json_annotation/json_annotation.dart';
import 'package:weather/src/core/constants.dart';

part 'open_weather_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenWeatherResponse {
  const OpenWeatherResponse({
    required this.weatherInfo,
    required this.reading,
  });

  factory OpenWeatherResponse.fromJson(JsonResponse json) =>
      _$OpenWeatherResponseFromJson(json);

  @JsonKey(name: 'weather')
  final List<WeatherInfo> weatherInfo;

  @JsonKey(name: 'main')
  final TemperatureReading reading;

  JsonResponse toJson() => _$OpenWeatherResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherInfo {
  const WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(JsonResponse json) =>
      _$WeatherInfoFromJson(json);

  final int id;
  final String main;
  final String description;
  final String icon;

  String get iconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TemperatureReading {
  const TemperatureReading({
    required this.temp,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
  });

  factory TemperatureReading.fromJson(JsonResponse json) =>
      _$TemperatureReadingFromJson(json);

  final double temp;

  final double feelsLike;

  @JsonKey(name: 'temp_min')
  final double minTemp;

  @JsonKey(name: 'temp_max')
  final double maxTemp;

  JsonResponse toJson() => _$TemperatureReadingToJson(this);
}
