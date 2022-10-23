class Temperature {
  const Temperature.celsius(this.celsius);

  final double celsius;

  double get fahrenheit => celsius * 1.8 + 32;

  double get kelvin => celsius + 273.15;
}
