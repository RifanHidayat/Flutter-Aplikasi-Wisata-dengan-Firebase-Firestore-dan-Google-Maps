import 'package:geolocator/geolocator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wisata/Route/locator.dart';

class LocationService {
  DialogService _dialogService = locator<DialogService>();

  Future searchLocationLong(val) async {
    try {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(val);
      var location;

      if (placemark.isNotEmpty) {
        location = placemark[0].toJson();
      }
      return location["position"]["longitude"].toString();
    } catch (e) {
      _dialogService.showDialog(
          title: 'Something Wrong', description: e.toString());
    }
  }

  Future searchLocationLat(val) async {
    try {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(val);
      var location;

      if (placemark.isNotEmpty) {
        location = placemark[0].toJson();
      }
      return location["position"]["latitude"].toString();
    } catch (e) {
      _dialogService.showDialog(
          title: 'Something Wrong', description: e.toString());
    }
  }
}
