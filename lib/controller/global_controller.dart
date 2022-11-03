import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx/api/fetch_weather.dart';
import 'package:weather_app_getx/model/weather_data.dart';

class GlobalController extends GetxController {
// create variable

  final RxBool _isLoading = true.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

// create variable instances
  RxBool checkLoading() => _isLoading;
  RxDouble getLongitude() => _longitude;
  RxDouble getLatitude() => _latitude;

  final weatherData = WeatherData().obs;

  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
// return service if enabled
    if (!isServiceEnabled) {
      return Future.error("location is not enabled");
    }
    //  status permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission == await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("location permission denied");
      }
    }
    //  getting current position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // update latitude and longitude
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
