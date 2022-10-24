import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/src/features/weather/presentation/city_list_page.dart';
import 'package:weather/src/features/weather/presentation/weather_list_page.dart';

enum AppRoute {
  weather,
  cities,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.weather.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const WeatherListPage(),
          );
        },
        routes: [
          GoRoute(
            path: AppRoute.cities.name,
            name: AppRoute.cities.name,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: const CityListPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
});
