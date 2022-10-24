import 'package:flutter/material.dart';
import 'package:weather/src/core/extensions/build_context_extensions.dart';
import 'package:weather/src/features/weather/presentation/widgets/city_list_view.dart';
import 'package:weather/src/themes/colors.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBlueColor,
        title: Text(
          context.localization.cities,
        ),
        actions: const [],
      ),
      body: const SafeArea(
        child: CityListView(),
      ),
    );
  }
}
