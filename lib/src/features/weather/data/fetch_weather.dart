import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/core/exceptions/exceptions.dart';
import 'package:weather/src/env/env.dart';
import 'package:weather/src/features/weather/data/city_db.dart';
import 'package:weather/src/features/weather/data/device_location.dart';
import 'package:weather/src/features/weather/models/city.dart';
import 'package:weather/src/features/weather/models/city_weather.dart';
import 'package:weather/src/features/weather/models/open_weather_response.dart';
import 'package:weather/src/features/weather/models/weather.dart';

abstract class IFetchWeather {
  Future<Weather> fetchCurrentWeather(double latitude, double longitude);
}

class OpenWeatherApi implements IFetchWeather {
  const OpenWeatherApi(this._dio);

  final Dio _dio;

  Future<Weather> fetchCityWeather(City city) async {
    try {
      var latitude = double.parse(city.latitude);
      var longitude = double.parse(city.longitude);
      return await fetchCurrentWeather(latitude, longitude);
    } on FormatException catch (e) {
      throw AppException(message: e.message);
    }
  }

  @override
  Future<Weather> fetchCurrentWeather(double latitude, double longitude) async {
    try {
      final response = await _dio.get('weather', queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'units': 'metric',
        'appid': Env.openWeatherMapApiKey,
      });
      final openWeather = OpenWeatherResponse.fromJson(response.data);
      final weather = Weather.fromOpenWeatherResponse(openWeather);
      return weather;
    } on DioError catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}

final openWeatherDio = Provider<Dio>((ref) {
  const openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5/';
  return Dio(BaseOptions(baseUrl: openWeatherBaseUrl));
});

final openWeatherAPIProvider = Provider<OpenWeatherApi>((ref) {
  final dio = ref.watch(openWeatherDio);
  return OpenWeatherApi(dio);
});

final fetchCitiesWeatherProvider =
    FutureProvider.autoDispose<CityWeatherList>((ref) async {
  final cities = await ref.watch(watchFavouriteCitiesProvider.future);

  final cityWeatherList = <CityWeather>[];
  for (var city in cities) {
    final response =
        await ref.watch(openWeatherAPIProvider).fetchCityWeather(city);
    final cw = CityWeather(city: city, weather: response);
    cityWeatherList.add(cw);
  }

  return cityWeatherList;
});

final fetchDeviceLocationWeatherProvider = FutureProvider<Weather>((ref) async {
  final position = await ref.watch(devicePostionProvider.future);
  final weather = await ref
      .watch(openWeatherAPIProvider)
      .fetchCurrentWeather(position.latitude, position.longitude);
  return weather;
});
