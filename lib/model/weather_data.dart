import 'package:weather_app_getx/model/weather_data_current.dart';
import 'package:weather_app_getx/model/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;

  WeatherData([this.current, this.hourly]);

  // function to fetch the values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
}
