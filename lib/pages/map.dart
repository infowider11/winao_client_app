import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../packages/packages/lib/utils/google_search/latlng.dart';
import '../packages/packages/lib/widget/search_widget.dart';
import '../services/api_urls.dart';
import '../services/webservices.dart';
import '../widgets/GOOGLEMAP.dart';
import '../widgets/customtextfield.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';

class map extends StatefulWidget {
  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();


}

class _mapState extends State<map> {

  String location ='Null, Press Button';
  String Address = 'search';
  GoogleMapController? mapController; //contrller for Google map
  // LatLng startLocation = LatLng(27.6602292, 85.308027);

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: MapSample(

                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Coordinates Points',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('ADDRESS',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('${Address}'),
                  ElevatedButton(onPressed: () async{
                    Position position = await _getGeoLocationPosition();
                    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                    GetAddressFromLatLong(position);
                  }, child: Text('Get Location'))
                ],
              ),
            ],
          ),


        ),
      ),
    );
  }
}

