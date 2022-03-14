import 'package:e_wan/parkingReservation.dart';
import 'package:e_wan/showParkingSlotDetails.dart';
import 'package:e_wan/signIn.dart';
import 'package:e_wan/startPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'location_tracking.dart';

class homePageController extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else if (snapshot.hasData){
          return startPage();
        }else if (snapshot.hasError){
          return Center(child: Text('Something went wrong!'));
        }else{
          return signIn();
        }
      },
    ),
  );
}
