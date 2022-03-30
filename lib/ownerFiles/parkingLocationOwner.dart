import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class parkingLocationOwner extends StatefulWidget {
  const parkingLocationOwner({Key? key}) : super(key: key);

  @override
  _parkingLocationState createState() => _parkingLocationState();
}

class _parkingLocationState extends State<parkingLocationOwner> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  int availableParkingSpaces = 0;
  int totalParkingSpaces = 0;
  var dbData;

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff6fbff),
      body: SafeArea(
        child: StreamBuilder(
          stream: database.child("userData").child(user.uid).child("ParkingLocation").onValue,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if (snapshot.hasError) {
              return const Text("Something went wrong");
            }else{

              dbData = (snapshot.data! as Event).snapshot.value;

              if(dbData != null){
                markers = Set();
                var entryList = dbData.entries.toList();

                for(int x = 0; x < dbData.length; x++){
                  Marker resultMarker = Marker(
                    markerId: MarkerId(entryList[x].value["markerID"]),
                    infoWindow: InfoWindow(
                        title: entryList[x].value["parkingName"],
                        snippet: "Click to view more details" ,
                        onTap: () {
                          Navigator.pushNamed(context, '/homePageOwner', arguments: {
                            'parkingLocationID': entryList[x].value["parkingName"]
                          });
                        }),
                    position: LatLng(entryList[x].value["parkingLat"], entryList[x].value["parkingLong"]),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet,
                    ),
                  );
                  markers.add(resultMarker);
                }
                return Stack(
                  children: <Widget>[
                    _buildGoogleMap(context),
                    /*_zoomminusfunction(),
                    _zoomplusfunction(),
                    _buildContainer(),*/
                  ],
                );
              }else{
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition:  CameraPosition(target: LatLng(7.071868, 125.614091), zoom: 16),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(7.071868, 125.614091), zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }
}
