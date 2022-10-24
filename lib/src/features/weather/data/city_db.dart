import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/features/weather/data/fetch_city.dart';
import 'package:weather/src/features/weather/data/hive_config.dart';
import 'package:weather/src/features/weather/models/city.dart';

abstract class ICityDB {
  Stream<Cities> watchCities();

  Future<void> saveCity(City city);

  Future<void> deleteCity(City city);
}

class FavouriteCityDB implements ICityDB {
  const FavouriteCityDB(this.ref);

  final Ref ref;

  CityBox get _favouriteCityBox => ref.read(favouriteCityBoxProvider);

  @override
  Stream<Cities> watchCities() async* {
    yield _favouriteCityBox.values.toList();

    await for (var _ in _favouriteCityBox.watch()) {
      yield _favouriteCityBox.values.toList();
    }
  }

  @override
  Future<void> saveCity(City city) async {
    unawaited(_favouriteCityBox.add(city));
  }

  @override
  Future<void> deleteCity(City city) async {
    unawaited(_favouriteCityBox.delete(city.key));
  }
}

final favouriteCityDBProvider = Provider<FavouriteCityDB>((ref) {
  return FavouriteCityDB(ref);
});

final watchFavouriteCitiesProvider = StreamProvider<Cities>((ref) async* {
  yield* ref.watch(favouriteCityDBProvider).watchCities();
});

/* ---------------------------------------------------------- */

class SeedFavouriteCityDB {
  const SeedFavouriteCityDB(this.ref);

  final Ref ref;

  static const _isNewUserKey = 'is_new_user';

  FavouriteCityDB get _favouriteCityDBProvider =>
      ref.read(favouriteCityDBProvider);

  IsNewUserBox get _isNewUserBoxProvider => ref.read(isNewUserBoxProvider);

  void seedDatabase() {
    final isNewUser =
        _isNewUserBoxProvider.get(_isNewUserKey, defaultValue: true) ?? true;
    if (isNewUser) {
      _seedDatabase();
    }
  }

  void _seedDatabase() {
    final cities = ref.watch(allCitiesProvider).sublist(0, 3);
    cities.forEach(_favouriteCityDBProvider.saveCity);
    unawaited(_isNewUserBoxProvider.put(_isNewUserKey, false));
  }
}

final seedFavouriteCityDBProvider = Provider<SeedFavouriteCityDB>((ref) {
  return SeedFavouriteCityDB(ref);
});
