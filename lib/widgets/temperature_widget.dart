import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/setting_bloc.dart';
import 'package:olife/blocs/theme_bloc.dart';
import 'package:olife/models/weather.dart';
import 'package:olife/states/setting_state.dart';
import 'package:olife/states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: BlocBuilder<SettingBloc, SettingState>(
            builder: (context, settingState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Temperature: ${weather.temp}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _themeState.textColor,
                    ),
                  ),
                  Text(
                    'Prediction: ${weather.minTemp} - ${weather.maxTemp}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _themeState.textColor,
                    ),
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
