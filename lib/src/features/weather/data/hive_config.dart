import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/src/features/weather/models/city.dart';

typedef CityBox = Box<City>;

typedef IsNewUserBox = Box<bool>;

/// Provider for [CityBox], the provider's value is
/// overriden in the main function.
final favouriteCityBoxProvider = Provider<CityBox>((ref) {
  throw UnimplementedError();
});

/// Provider for [IsNewUserBox], the provider's value is
/// overriden in the main function.
final isNewUserBoxProvider = Provider<IsNewUserBox>((ref) {
  throw UnimplementedError();
});

/// Utility class for [HiveType.typeId]
class HiveTypeId {
  const HiveTypeId._();

  static const city = 0;
}

/// Utility class for Hive box names
class HiveBoxName {
  const HiveBoxName._();

  static const favouriteCity = 'FAVOURITE_CITY';

  static const isNewUser = 'IS_NEW_USER';
}
