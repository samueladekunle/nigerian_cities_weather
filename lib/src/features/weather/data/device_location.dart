import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/src/core/exceptions/exceptions.dart';
import 'package:weather/src/localization/localization_provider.dart';

class DeviceLocation {
  const DeviceLocation(this.ref);

  final Ref ref;

  /// Opens the app settings page.
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  /// Opens the device's location settings page.
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// Returns a ```Future<Position>```.
  /// If there is an exception, throws ```AppException```
  Future<Position> getCurrentPosition() async {
    try {
      final isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        final statusMessage =
            ref.read(appLocalizationsProvider).locationDisabled;
        throw LocationNotEnabledException(message: statusMessage);
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          final statusMessage =
              ref.read(appLocalizationsProvider).locationDenied;
          throw LocationPermissionDeniedException(message: statusMessage);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        final statusMessage =
            ref.read(appLocalizationsProvider).locationDeniedForever;
        throw LocationPermissionDeniedForeverException(message: statusMessage);
      }

      final position = await Geolocator.getCurrentPosition();
      return position;
    } on PlatformException catch (exception) {
      throw AppException.fromPlatformException(exception);
    }
  }
}

final deviceLocationProvider = Provider<DeviceLocation>((ref) {
  return DeviceLocation(ref);
});

final devicePostionProvider = FutureProvider<Position>((ref) async {
  return await ref.watch(deviceLocationProvider).getCurrentPosition();
});
