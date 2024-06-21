import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future <void> CurrentLocation () async{

    try{
      await askPermission(); // This do not exists

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;

    }catch(e){
      print(e);
    }
  }
  askPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return askPermission();
      }
    }
  }
}


