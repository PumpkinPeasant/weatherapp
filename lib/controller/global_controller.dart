import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final Rx<Placemark> _placemark = Placemark().obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getLattitude() => _lattitude;

  RxDouble getLongitude() => _longitude;

  Rx<Placemark> getPlacemark() => _placemark;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
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

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isLoading.value = false;
      getAddress();
    });
  }

  getAddress() async {
    List<Placemark> placemark = await placemarkFromCoordinates(getLattitude().value, getLongitude().value);
    Placemark place = placemark[0];
    print(place);
    return place;
  }
}
