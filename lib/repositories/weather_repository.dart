import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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

  Future<Weather> fetchWeather(int locationId) async {
    final response = await httpClient.get(weatherUrl(locationId));
    if(response.statusCode == 200) {
      final weather = jsonDecode(response.body);
      return Weather.fromJson(weather);
    } else {
      throw Exception('Error getting weather of ${locationId}');
    }
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationFromCity(city);
    return fetchWeather(locationId);
  }
}