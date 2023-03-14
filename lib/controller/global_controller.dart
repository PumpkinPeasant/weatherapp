import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/geolocation.dart';
import 'package:weatherapp/model/weather_data.dart';

import '../api/fetch_weather.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxBool _hasPermission = false.obs;
  final RxString _permissionError = ''.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final Rx<Geolocation> _placemark = Geolocation(
    locality: '',
    district: '',
  ).obs;
  final RxInt _cardIndex = 0.obs;

  RxBool checkLoading() => _isLoading;

  RxBool checkPermission() => _hasPermission;

  RxString getPermissionError() => _permissionError;

  RxDouble getLattitude() => _lattitude;

  RxDouble getLongitude() => _longitude;

  Rx<Geolocation> getPlacemark() => _placemark;

  final weatherData = WeatherData().obs;

  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
      setLocale();
    } else {
      getIndex();
    }
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _permissionError.value = 'Невозможно получить местоположение';
      _isLoading.value = false;
      return;
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      _permissionError.value = 'Функция определения местоположения отключена';
      _isLoading.value = false;
      return;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
        _permissionError.value = 'Невозможно получить местоположение';
        _isLoading.value = false;
        return;
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _placemark.value = getAddress(value);
        _isLoading.value = false;
        _hasPermission.value = true;
      });
    });
  }

  getAddress(weatherData) {
    Geolocation place = weatherData.geolocation;
    return place;
  }

  setLocale() {
    initializeDateFormatting('ru_RU', null);
    Intl.defaultLocale = 'ru';
  }

  getIndex() {
    return _cardIndex;
  }
}
