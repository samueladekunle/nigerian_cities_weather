import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/features/weather/data/device_location.dart';
import 'package:weather/src/features/weather/data/fetch_weather.dart';
import 'package:weather/src/features/weather/models/weather.dart';

class DeviceLocationNotifier extends StateNotifier<AsyncValue<Weather?>> {
  DeviceLocationNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> fetchWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<Weather>(() async {
      final position = await ref.read(devicePostionProvider.future);
      final weather = await ref
          .read(openWeatherAPIProvider)
          .fetchCurrentWeather(position.latitude, position.longitude);
      return weather;
    });
  }
}

final deviceLocationNotifierProvider =
    StateNotifierProvider<DeviceLocationNotifier, AsyncValue>((ref) {
  return DeviceLocationNotifier(ref);
});
