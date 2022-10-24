import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/features/weather/data/city_db.dart';
import 'package:weather/src/features/weather/models/city.dart';

abstract class IFetchCity {
  Future<Cities> fetchCities();
}

class FetchCityLocal implements IFetchCity {
  @override
  Future<Cities> fetchCities(
      [String countryIso = 'ng', int offset = 15]) async {
    final source =
        await rootBundle.loadString('assets/json/cities/$countryIso.json');
    final list = jsonDecode(source) as List<dynamic>;

    return list.map((json) => City.fromJson(json)).toList().sublist(0, offset);
  }
}

final fetchCityLocalProvider = Provider<FetchCityLocal>((ref) {
  return FetchCityLocal();
});

final allCitiesProvider = Provider<Cities>((ref) {
  throw UnimplementedError();
});

final filterCitiesProvider = Provider<Cities>((ref) {
  final allCities = ref.watch(allCitiesProvider).toList();
  final favouriteCities = ref.watch(watchFavouriteCitiesProvider).value;

  if (favouriteCities != null) {
    allCities.removeWhere((element) => favouriteCities.contains(element));
  }

  return allCities;
});
