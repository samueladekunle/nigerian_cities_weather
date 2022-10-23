// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityAdapter extends TypeAdapter<City> {
  @override
  final int typeId = 0;

  @override
  City read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return City(
      name: fields[1] as String,
      latitude: fields[2] as String,
      longitude: fields[3] as String,
      countryIso: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.countryIso);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      name: json['city'] as String,
      latitude: json['lat'] as String,
      longitude: json['lng'] as String,
      countryIso: json['iso2'] as String,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'city': instance.name,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'iso2': instance.countryIso,
    };
