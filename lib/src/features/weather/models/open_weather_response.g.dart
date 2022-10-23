// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenWeatherResponse _$OpenWeatherResponseFromJson(Map<String, dynamic> json) =>
    OpenWeatherResponse(
      weatherInfo: (json['weather'] as List<dynamic>)
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      reading:
          TemperatureReading.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenWeatherResponseToJson(
        OpenWeatherResponse instance) =>
    <String, dynamic>{
      'weather': instance.weatherInfo.map((e) => e.toJson()).toList(),
      'main': instance.reading.toJson(),
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

TemperatureReading _$TemperatureReadingFromJson(Map<String, dynamic> json) =>
    TemperatureReading(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      minTemp: (json['temp_min'] as num).toDouble(),
      maxTemp: (json['temp_max'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureReadingToJson(TemperatureReading instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.minTemp,
      'temp_max': instance.maxTemp,
    };
