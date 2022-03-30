import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class parkingLocation extends StatefulWidget {
  const parkingLocation({Key? key}) : super(key: key);

  @override
  _parkingLocationState createState() => _parkingLocationState();
}

class _parkingLocationState extends State<parkingLocation> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set();

  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  int availableParkingSpaces = 0;
  int totalParkingSpaces = 0;
  var dbData;
  var dbData2;

  late LocationData destinationLocation;

  late Location location;
  LocationData? currentLocation;
  late StreamSubscription<LocationData> subscription;

  @override
  void initState() {
    super.initState();

    location = Location();

    subscription = location.onLocationChanged.listen((clocation) {
      currentLocation = clocation;
      updatePinsOnMap();
    });

    setInitialLocation();
  }

  double zoomVal = 5.0;

  void setInitialLocation() async {
    await location.getLocation().then((value) {
      currentLocation = value;
      setState(() {});
    });

  }

  void showLocationPins() {
    var sourceposition = LatLng(
        currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);

    markers.add(Marker(
      markerId: MarkerId('sourcePosition'),
      position: sourceposition,
    ));

  }

  void updatePinsOnMap() async {

    var sourcePosition = LatLng(
        currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);

    markers.add(Marker(
      markerId: MarkerId('sourcePosition'),
      position: sourcePosition,
    ));

    database.child("userData").child(user.uid).child("CurrentLoc").set({
      "CurrentLocLat" : sourcePosition.latitude,
      "CurrentLocLng" : sourcePosition.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff6fbff),
      body: SafeArea(
        child: StreamBuilder(
          stream: database.child("userData").child(user.uid).child("CurrentLoc").onValue,
          builder: (context, snapshot1){
            if (snapshot1.connectionState == ConnectionState.waiting) {
            return const Center(
            child: CircularProgressIndicator(),
            );
            }else if (snapshot1.hasError) {
            return const Text("Something went wrong");
            }else{
              markers = Set();
              dbData2 = (snapshot1.data! as Event).snapshot.value;

              if(dbData2 != null) {
                showLocationPins();


                return StreamBuilder(
                  stream: database
                      .child("ParkingLocation")
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    } else {
                      dbData = (snapshot.data! as Event).snapshot.value;

                      if (dbData != null) {
                        var entryList = dbData.entries.toList();

                        for (int x = 0; x < dbData.length; x++) {
                          Marker resultMarker = Marker(
                            markerId: MarkerId(entryList[x].value["markerID"]),
                            infoWindow: InfoWindow(
                                title: entryList[x].value["parkingName"],
                                snippet: "Click to view more details",
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/homePage', arguments: {
                                    'parkingLocationID': entryList[x]
                                        .value["parkingName"]
                                  });
                                }),
                            position: LatLng(entryList[x].value["parkingLat"],
                                entryList[x].value["parkingLong"]),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueViolet,
                            ),
                          );
                          markers.add(resultMarker);
                        }
                        return Stack(
                          children: <Widget>[
                            _buildGoogleMap(context),
                          ],
                        );
                      }
                      else {
                        CameraPosition initialCameraPosition = CameraPosition(
                          zoom: 16,
                          tilt: 0,
                          bearing: 30,
                          target: currentLocation != null
                              ? LatLng(currentLocation!.latitude ?? 0.0,
                              currentLocation!.longitude ?? 0.0)
                              : LatLng(0.0, 0.0),
                        );

                        return SafeArea(
                            child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GoogleMap(
                                compassEnabled: true,
                                mapType: MapType.normal,
                                markers: markers,
                                initialCameraPosition: initialCameraPosition,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
                            )
                        );
                      }
                    }
                  },
                );
              }else{
                return SizedBox();
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      zoom: 16,
      tilt: 0,
      bearing: 30,
      target: currentLocation != null
          ? LatLng(currentLocation!.latitude ?? 0.0,
          currentLocation!.longitude ?? 0.0)
          : LatLng(0.0, 0.0),
    );

    return currentLocation == null ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
        : SafeArea(
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition:  initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            markers: markers,
          ),
        )
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
