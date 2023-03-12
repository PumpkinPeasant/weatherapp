import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_data.dart';

import '../api/fetch_weather.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final Rx<Placemark> _placemark = Placemark().obs;
  final RxInt _cardIndex = 0.obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getLattitude() => _lattitude;

  RxDouble getLongitude() => _longitude;

  Rx<Placemark> getPlacemark() => _placemark;

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
      return Future.error('Невозможно получить местоположение');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Функция определения местоположения отключена');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Невозможно получить местоположение');
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      _placemark.value = await getAddress();

      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  getAddress() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        getLattitude().value, getLongitude().value);
    Placemark place = placemark[0];
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
