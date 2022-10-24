# Weather

This app displays the weather of selected Nigerian cities

The weather data are gotten from [Open Weather Map](https://openweathermap.org/)

The cities data are gotten from [Simple Maps](https://simplemaps.com/data/ng-cities)

## Getting Started

Get an [API key](https://home.openweathermap.org/api_keys) from Open Weather Map

Create an `.env` file in the project's root, and paste the text below into the file


```
OPEN_WEATHER_MAP_API_KEY=<YOUR_API_KEY>
```

Replace ```<YOUR_API_KEY>``` with your Open Weather Map [API key](https://home.openweathermap.org/api_keys)

`cd` into the project's root directory and run

```
flutter pub run build_runner build --delete-conflicting-outputs

flutter run
```