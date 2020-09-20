import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent();
}
class WeatherEventRequest extends WeatherEvent {
  final String city;
  WeatherEventRequest({@required this.city}): assert(city != null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;
  WeatherEventRefresh({@required this.city}): assert(city != null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}