import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/core/exceptions/exceptions.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/features/weather/data/device_location.dart';
import 'package:weather/src/features/weather/models/weather.dart';
import 'package:weather/src/features/weather/presentation/notifiers/device_location_notifier.dart';
import 'package:weather/src/features/weather/presentation/widgets/weather_bottom_sheet_card.dart';

class CurrentLocationIconButton extends ConsumerWidget {
  const CurrentLocationIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(deviceLocationNotifierProvider, (previous, next) {
      if (previous is AsyncLoading) {
        context.dismissProgressIndicator();
      }

      if (next is AsyncLoading) {
        context.showProgressIndicator();
      } else if (next is AsyncData) {
        if (next.value is Weather) {
          final weather = next.value as Weather;
          context.showBottomSheet(
              child: WeatherBottomSheetCard(
            weather: weather,
          ));
        }
      } else if (next is AsyncError) {
        final error = next.error;
        if (error is LocationNotEnabledException) {
          ref.read(deviceLocationProvider).openLocationSettings();
        } else if (error is LocationPermissionDeniedException ||
            error is LocationPermissionDeniedForeverException) {
          ref.read(deviceLocationProvider).openAppSettings();
        } else if (error is AppException) {
          final exception = next.error as AppException;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(exception.message)));
        }
      }
    });

    return IconButton(
      onPressed: () =>
          ref.read(deviceLocationNotifierProvider.notifier).fetchWeather(),
      icon: const Icon(Icons.location_pin),
      iconSize: 30,
      color: Colors.white,
      tooltip: context.localization.currentLocationWeather,
    );
  }
}
