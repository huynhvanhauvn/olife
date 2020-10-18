import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:olife/models/city.dart';
import 'package:olife/models/weather.dart';

const baseUrl = 'https://www.metaweather.com';
final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';
class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({@required this.httpClient}): assert(httpClient != null);

  Future<int> getLocationFromCity(String city) async {
    final response = await httpClient.get(locationUrl(city));
    if(response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? 0;
    } else {
      throw Exception('Error getting location of ${city}');
    }
  }

  Future<List<City>> getListCity(String city) async {
    final response = await httpClient.get(locationUrl(city));
    if(response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      print(cities);
      return fromJsonToListCity(cities);
    } else {
      throw Exception('Error getting location of ${city}');
    }
  }

  Future<List<Weather>> fetchWeather(int locationId) async {
    final response = await httpClient.get(weatherUrl(locationId));
    if(response.statusCode == 200) {
      final weather = jsonDecode(response.body);
      return fromJsonToList(weather);
    } else {
      throw Exception('Error getting weather of ${locationId}');
    }
  }

  Future<List<Weather>> getWeatherFromCity(String city) async {
    final int locationId = await getLocationFromCity(city);
    return fetchWeather(locationId);
  }

  List<Weather> fromJsonToList(dynamic jsonObject) {
    final List<Weather> weathers = List();
    final List<dynamic> list = jsonObject['consolidated_weather'];
    list.forEach((element) {
      final consolidatedWeather = element;
      final weather = Weather(
          weatherCondition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']) ?? '',
          formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
          temp: consolidatedWeather['the_temp'] as double,
          maxTemp: consolidatedWeather['max_temp'] as double,
          minTemp: consolidatedWeather['min_temp'] as double,
          locationId: jsonObject['woeid'] as int,
          created: consolidatedWeather['created'],
          lastUpdated: DateTime.now(),
          location: jsonObject['title']
      );
      weathers.add(weather);
    });
    return weathers;
  }

  List<City> fromJsonToListCity(List<dynamic> objects) {
    final List<City> cities = List();
    objects.forEach((element) {
      final List<double> mLatLng = List();
      final List<String> strLatLng = (element['latt_long'] as String).split(',');
      mLatLng.add(double.parse(strLatLng[0]));
      mLatLng.add(double.parse(strLatLng[1]));
      final city = City(
        title: element['title'] ?? '',
        locationType: element['location_type'] ?? 'City',
        woeid: element['weoid'],
        latLng: mLatLng,
      );
      cities.add(city);
    });
    return cities;
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