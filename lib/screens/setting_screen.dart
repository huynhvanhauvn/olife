import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/blocs/setting_bloc.dart';
import 'package:olife/events/setting_event.dart';
import 'package:olife/states/setting_state.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, settingState) {
          return ListTile(
            title: Text('Temperature Unit'),
            isThreeLine: true,
            subtitle: Text(
                settingState.temperatureUnit == TemperatureUnit.celsius
                    ? 'Celsius'
                    : 'Fahrenheit'),
            trailing: Switch(
              value: settingState.temperatureUnit == TemperatureUnit.celsius,
              onChanged: (_) => BlocProvider.of<SettingBloc>(context).add(
                SettingEventToggleUnit()
              ),
            ),
          );
        },
      ),
    );
  }
}
