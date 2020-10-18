import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/city_bloc.dart';
import 'package:olife/blocs/setting_bloc.dart';
import 'package:olife/blocs/theme_bloc.dart';
import 'package:olife/blocs/weather_bloc.dart';
import 'package:olife/observers/weather_observer.dart';
import 'package:olife/repositories/weather_repository.dart';
import 'package:olife/screens/weather_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  print(weatherRepository);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<SettingBloc>(
        create: (context) => SettingBloc(),
      ),
      BlocProvider<CityBloc>(
        create: (context) => CityBloc(repository: weatherRepository),
      )
    ],
    child: MyApp(
      weatherRepository: weatherRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}
