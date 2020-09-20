import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:olife/models/weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState();
  @override
  // TODO: implement props
  List<Object> get props => throw [];
}

class WeatherStateInitial extends WeatherState {}
class WeatherStateLoading extends WeatherState {}
class WeatherStateSuccess extends WeatherState {
  final Weather weather;
  WeatherStateSuccess({@required this.weather}) : assert(weather != null);
  @override
  // TODO: implement props
  List<Object> get props => throw [weather];
}
class WeatherStateFailure extends WeatherState {}