import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum TemperatureUnit {
  fahrenheit,
  celsius
}

class SettingState extends Equatable {
  final TemperatureUnit temperatureUnit;
  SettingState({@required this.temperatureUnit}) : assert(temperatureUnit != null);

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnit];
}