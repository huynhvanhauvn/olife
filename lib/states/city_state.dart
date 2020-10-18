import 'package:equatable/equatable.dart';
import 'package:olife/models/city.dart';

abstract class CityState extends Equatable {
  CityState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CityStateInitial extends CityState {}
class CityStateLoading extends CityState {}
class CityStateSuccess extends CityState {
  final List<City> cities;
  CityStateSuccess({this.cities}) : assert(cities != null);

  @override
  // TODO: implement props
  List<Object> get props => [cities];
}
class CityStateFailure extends CityState {}