import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olife/events/setting_event.dart';
import 'package:olife/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is SettingEventToggleUnit) {
      yield SettingState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
    }
  }
}
