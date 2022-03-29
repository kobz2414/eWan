import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class addParkingPlaceOwner extends StatefulWidget {
  const addParkingPlaceOwner({Key? key}) : super(key: key);

  @override
  State<addParkingPlaceOwner> createState() => _addParkingPlaceOwnerState();
}

class _addParkingPlaceOwnerState extends State<addParkingPlaceOwner> {
  List<Marker> selectedMarker = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(7.071868, 125.614091), zoom: 16),
          markers: Set.from(selectedMarker),
          onTap: _handleTap,
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint){
    setState(() {
      selectedMarker = [];
      selectedMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
              title: "Selected Parking Area",
              snippet: "Click to add parking details" ,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/addParkingPlaceDetailsOwner', arguments: {
                  'parkingLocationLat': tappedPoint.latitude,
                  'parkingLocationLng': tappedPoint.longitude
                });
              }),
        )
      );
    });
  }

}
