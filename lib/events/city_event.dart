import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  CityEvent();
}

class CityRequest extends CityEvent {
  final String city;
  CityRequest({this.city}) : assert(city != null);
  @override
  // TODO: implement props
  List<Object> get props => [city];

}