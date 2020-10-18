import 'package:equatable/equatable.dart';

enum LocationType {
  City,
  State,
  Country,
  Continent
}
class City extends Equatable {
  final String title;
  final LocationType locationType;
  final int woeid;
  final List<double> latLng;

  City({this.title, this.locationType, this.woeid, this.latLng});

  @override
  // TODO: implement props
  List<Object> get props => [
    title,
    locationType,
    latLng
  ];
}