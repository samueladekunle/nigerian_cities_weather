import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/src/core/constants.dart';
import 'package:weather/src/features/weather/data/hive_config.dart';

part 'city.g.dart';

typedef Cities = List<City>;

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: HiveTypeId.city)
class City extends HiveObject with EquatableMixin {
  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryIso,
  });

  factory City.empty() => City(
        name: '',
        latitude: '',
        longitude: '',
        countryIso: '',
      );

  factory City.fromJson(JsonResponse json) => _$CityFromJson(json);

  @JsonKey(name: 'city')
  @HiveField(1)
  final String name;

  @JsonKey(name: 'lat')
  @HiveField(2)
  final String latitude;

  @JsonKey(name: 'lng')
  @HiveField(3)
  final String longitude;

  @JsonKey(name: 'iso2')
  @HiveField(4)
  final String countryIso;

  @override
  List<Object?> get props => [
        name,
        latitude,
        longitude,
        countryIso,
      ];

  @override
  bool? get stringify => true;

  JsonResponse toJson() => _$CityToJson(this);
}
