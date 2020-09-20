import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:olife/models/weather.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent();
}

class ThemeEventWeatherChange extends ThemeEvent {
  final WeatherCondition weatherCondition;

  ThemeEventWeatherChange({@required this.weatherCondition}) : assert(weatherCondition != null);

  @override
  // TODO: implement props
  List<Object> get props => [weatherCondition];
}
