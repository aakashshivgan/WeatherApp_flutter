import 'package:weather_app_getx/model/weather_data_current.dart';

class WeatherData {
  final WeatherDataCurrent? current;

  WeatherData([this.current]);

  // function to fetch the values
  WeatherDataCurrent getCurrentWeather() => current!;
}
