import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/core/widgets/async_value_widget.dart';
import 'package:weather/src/features/weather/data/city_db.dart';
import 'package:weather/src/features/weather/data/fetch_city.dart';
import 'package:weather/src/features/weather/models/city.dart';

class CityListView extends ConsumerWidget {
  const CityListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCities = ref.watch(filterCitiesProvider);
    final favouriteCities = ref.watch(watchFavouriteCitiesProvider);

    return AsyncValueWidget<Cities>(
      value: favouriteCities,
      data: (favouriteCities) {
        return _CityListView(
          allCities: filteredCities,
          favouriteCities: favouriteCities,
        );
      },
    );
  }
}

class _CityListView extends StatelessWidget {
  _CityListView({
    required this.allCities,
    required this.favouriteCities,
  });

  final Cities allCities;
  final Cities favouriteCities;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (favouriteCities.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.localization.favouriteCities,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: favouriteCities
                    .map((e) => Consumer(builder: (context, ref, child) {
                          return ListTile(
                            title: Text(e.name),
                            trailing: IconButton(
                              onPressed: () {
                                ref.read(favouriteCityDBProvider).deleteCity(e);
                              },
                              icon: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                          );
                        }))
                    .toList(),
              ),
              const Divider(
                thickness: 2,
                color: Colors.white,
              ),
            ],
            if (allCities.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.localization.allCities,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: allCities
                    .map((e) => Consumer(builder: (context, ref, child) {
                          return ListTile(
                            title: Text(e.name),
                            trailing: IconButton(
                              onPressed: () {
                                ref.read(favouriteCityDBProvider).saveCity(e);
                              },
                              icon: const Icon(
                                Icons.star_outline,
                                color: Colors.yellow,
                              ),
                            ),
                          );
                        }))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
