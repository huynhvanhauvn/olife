import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/events/theme_event.dart';
import 'package:olife/models/weather.dart';
import 'package:olife/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc():super(ThemeState(backgroundColor: Colors.blue, textColor: Colors.white));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async*{
    ThemeState newTheme;
    if(event is ThemeEventWeatherChange) {
      final WeatherCondition weatherCondition = event.weatherCondition;
      if(weatherCondition == WeatherCondition.clear || weatherCondition == WeatherCondition.lightCloud) {
        newTheme = ThemeState(backgroundColor: Colors.blue, textColor: Colors.white);
      } else {
        newTheme = ThemeState(backgroundColor: Colors.blueGrey, textColor: Colors.white);
      }
    }
  }
}