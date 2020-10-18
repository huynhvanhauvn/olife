import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/setting_bloc.dart';
import 'package:olife/blocs/theme_bloc.dart';
import 'package:olife/models/weather.dart';
import 'package:olife/states/setting_state.dart';
import 'package:olife/states/theme_state.dart';
import 'package:olife/utils/format.dart';

class TemperatureWidget extends StatefulWidget {
  final Weather weather;

  TemperatureWidget({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => TemperatureState();
}

class TemperatureState extends State<TemperatureWidget>
    with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: 180).animate(_arrowAnimationController);
  }

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _arrowAnimationController,
                    builder: (context, child) => Transform.rotate(
                      angle: _arrowAnimation.value,
                      child: Image.asset(
                        'assets/icons/pin_wheel.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${MyFormatter().numberFormat.format(widget.weather.temp)}',
                        style: TextStyle(
                          fontSize: 50,
                          color: _themeState.textColor,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${MyFormatter().numberFormat.format(widget.weather.maxTemp)}',
                            style: TextStyle(
                              fontSize: 18,
                              color: _themeState.textColor,
                            ),
                          ),
                          Text(
                            '${MyFormatter().numberFormat.format(widget.weather.minTemp)}',
                            style: TextStyle(
                              fontSize: 18,
                              color: _themeState.textColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
