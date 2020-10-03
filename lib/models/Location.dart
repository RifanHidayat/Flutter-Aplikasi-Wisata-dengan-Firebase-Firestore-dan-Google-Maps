import 'package:stacked/stacked.dart';
import 'package:wisata/Route/locator.dart';
import 'package:wisata/services/location_service.dart';

class HomeViewModel extends BaseViewModel {
  LocationService _locationService = locator<LocationService>();
  String _latLong;
  String _getSearchLocation;
  String _getNameLocation;
  String _getLat;
  String _getLong;

  String get latLong => _latLong;

  String get getSearchLocation => _getSearchLocation;

  String get getNameLocation => _getNameLocation;

  String get Lat => _getLat;

  String get Long => _getLong;

  Future searchLocationLong(val) async {
    var position = await _locationService.searchLocationLong(val);
    print(position);
    _getLong = position.toString();
    notifyListeners();
  }

  Future searchLocationLat(val) async {
    var position = await _locationService.searchLocationLat(val);
    print(position);
    _getLat = position.toString();
    notifyListeners();
  }
}
