import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/src/core/exceptions/exceptions.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/core/widgets/async_value_widget.dart';
import 'package:weather/src/features/weather/data/city_db.dart';
import 'package:weather/src/features/weather/data/fetch_weather.dart';
import 'package:weather/src/features/weather/presentation/widgets/current_location_icon_button.dart';
import 'package:weather/src/features/weather/presentation/widgets/weather_carousel.dart';
import 'package:weather/src/routes/routes.dart';
import 'package:weather/src/themes/colors.dart';

class WeatherListPage extends ConsumerStatefulWidget {
  const WeatherListPage({super.key});

  @override
  ConsumerState<WeatherListPage> createState() => _WeatherListPageState();
}

class _WeatherListPageState extends ConsumerState<WeatherListPage> {
  @override
  void initState() {
    super.initState();
    ref.read(seedFavouriteCityDBProvider).seedDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final weatherList = ref.watch(fetchCitiesWeatherProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: CurrentLocationIconButton(),
              ),
              const Spacer(),
              AsyncValueWidget(
                value: weatherList,
                data: (weatherList) {
                  return WeatherCarousel(
                    weatherList: weatherList,
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.accentColor,
                    ),
                  ),
                ),
                error: (error, _) {
                  var message = context.localization.defaultErrorMessage;
                  if (error is AppException) {
                    message = error.message;
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message,
                        style: context.textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () =>
                            ref.refresh(fetchCitiesWeatherProvider.future),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          context.goNamed(AppRoute.cities.name);
        },
        label: Text(
          context.localization.addCityButtonLabel,
          style: const TextStyle(
            color: AppColors.rainBlueLight,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        icon: const Icon(
          Icons.add,
          size: 30,
          color: AppColors.rainBlueLight,
        ),
      ),
    );
  }
}
