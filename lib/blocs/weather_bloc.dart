import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/events/weather_event.dart';
import 'package:olife/models/weather.dart';
import 'package:olife/repositories/weather_repository.dart';
import 'package:olife/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is WeatherEventRequest) {
      yield WeatherStateLoading();
      try {
        final Weather weather = await weatherRepository.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch(exception) {
        yield WeatherStateFailure();
      }
    } else if(event is WeatherEventRefresh) {
      yield WeatherStateLoading();
      try {
        final Weather weather = await weatherRepository.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch(exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
