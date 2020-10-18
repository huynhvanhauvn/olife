import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown,
  hail
}

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather(
      {this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location});

  @override
  // TODO: implement props
  List<Object> get props => [
    weatherCondition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
  ];

  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']) ?? '',
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: jsonObject['woeid'] as int,
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: jsonObject['title']
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String condition) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[condition] ?? WeatherCondition.unknown;
  }
}
