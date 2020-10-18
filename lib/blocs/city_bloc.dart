import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/events/city_event.dart';
import 'package:olife/models/city.dart';
import 'package:olife/repositories/weather_repository.dart';
import 'package:olife/states/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final WeatherRepository repository;
  CityBloc({@required this.repository}) : assert(repository != null), super(CityStateInitial());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async*{
    if(event is CityRequest) {
      yield CityStateLoading();
      try {
        final List<City> cities = await repository.getListCity(event.city);
        yield CityStateSuccess(cities: cities);
      } catch(exception) {
        yield CityStateFailure();
      }
    }
  }
}