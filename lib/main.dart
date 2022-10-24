import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/src/features/weather/data/fetch_city.dart';
import 'package:weather/src/features/weather/data/hive_config.dart';
import 'package:weather/src/features/weather/models/city.dart';

import 'src/app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    Hive.registerAdapter(CityAdapter());

    // Open favourite cities box.
    final favouriteCityBox =
        await Hive.openBox<City>(HiveBoxName.favouriteCity);

    // Open is new user box.
    final isNewUserBox = await Hive.openBox<bool>(HiveBoxName.isNewUser);

    // Fetch 15 cities.
    final cities = await FetchCityLocal().fetchCities();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
    };

    runApp(ProviderScope(
      overrides: [
        allCitiesProvider.overrideWithValue(cities),
        favouriteCityBoxProvider.overrideWithValue(favouriteCityBox),
        isNewUserBoxProvider.overrideWithValue(isNewUserBox),
      ],
      child: const WeatherApp(),
    ));
  }, (error, stack) {
    //
  });
}
