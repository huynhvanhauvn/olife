import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/theme_bloc.dart';
import 'package:olife/blocs/weather_bloc.dart';
import 'package:olife/events/theme_event.dart';
import 'package:olife/events/weather_event.dart';
import 'package:olife/screens/search_screen.dart';
import 'package:olife/screens/setting_screen.dart';
import 'package:olife/states/theme_state.dart';
import 'package:olife/states/weather_state.dart';
import 'package:olife/widgets/temperature_widget.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer _completer;

  @override
  void initState() {
    // TODO: implement initState
    _completer = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final typedCity = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
                if(typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context).add(
                    WeatherEventRequest(city: typedCity)
                  );
                }
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              }),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChange(
                  weatherCondition: weatherState.weathers[0].weatherCondition));
            }
            _completer?.complete();
            _completer = Completer();
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weathers[0];
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherEventRefresh(city: weather.location));
                      return _completer.future;
                    },
                    child: Container(
                      color: themState.backgroundColor,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Text(
                                weather.location,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themState.textColor,
                                ),
                              ),
                              TemperatureWidget(weather: weather),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return AlertDialog(
                content: Text('Loading Error'),
              );
            }
            return Center(
              child: Text(
                'Select a City',
                style: TextStyle(fontSize: 30, color: Colors.amber),
              ),
            );
          },
        ),
      ),
    );
  }
}
