import 'package:e_wan/GoogleFiles/google_sign_in.dart';
import 'package:e_wan/homePageController.dart';
import 'package:e_wan/parkingLocation.dart';
import 'package:e_wan/parkingReservation.dart';
import 'package:e_wan/parkingSlot.dart';
import 'package:e_wan/paymentDetails.dart';
import 'package:e_wan/showParkingSlotDetails.dart';
import 'package:e_wan/startPage.dart';
import 'package:e_wan/transactionDetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:e_wan/homePage.dart';

import 'location_tracking.dart';
import 'ownerFiles/addParkingPlaceDetailsOwner.dart';
import 'ownerFiles/addParkingPlaceOwner.dart';
import 'ownerFiles/addParkingSlotOwner.dart';
import 'ownerFiles/homePageOwner.dart';
import 'ownerFiles/parkingLocationOwner.dart';
import 'ownerFiles/parkingSlotDetailsOwner.dart';
import 'ownerFiles/parkingSlotOwner.dart';
import 'ownerFiles/parkingTypeOwner.dart';
import 'ownerFiles/paymentMethodAddOwner.dart';
import 'ownerFiles/paymentMethodDetailsOwner.dart';
import 'ownerFiles/paymentMethodOwner.dart';
import 'ownerFiles/requestDetailsOwner.dart';
import 'ownerFiles/startPageOwner.dart';
import 'ownerFiles/transactionDetailsOwner.dart';
import 'ownerFiles/transactionsOwner.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(homeScreen());
}

class homeScreen extends StatelessWidget {
  static const String title = "Home Page";

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: title,

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Metropolis',
        ),
        home: homePageController(),
        routes: {
          '/parkingLocation': (context) => parkingLocation(),
          '/startPage': (context) => startPage(),
          '/homePageController': (context) => homePageController(),
          '/homePage': (context) => homePage(),
          '/transactionDetails' : (context) => transactionDetails(),
          '/parkingSlot' : (context) => parkingSlot(),
          '/showParkingSlotDetails'  : (context) => showParkingSlotDetails(),
          '/parkingReservation' : (context) => parkingReservation(),
          '/paymentDetails' : (context) => paymentDetails(),
          '/googleMapsDirections' : (context) => LocationTracking(),

          '/parkingLocationOwner': (context) => parkingLocationOwner(),
          '/startPageOwner': (context) => startPageOwner(),
          '/homePageOwner': (context) => homePageOwner(),
          '/transactionDetailsOwner' : (context) => transactionDetailsOwner(),
          '/parkingSlotOwner' : (context) => parkingSlotOwner(),
          '/parkingTypeOwner' : (context) => parkingTypeOwner(),
          '/requestDetailsOwner' : (context) => requestDetailsOwner(),
          '/transactionsOwner' : (context) => transactionsOwner(),
          '/paymentMethodOwner' : (context) => paymentMethodOwner(),
          '/paymentMethodDetailsOwner' : (context) => paymentMethodDetailsOwner(),
          '/paymentMethodAddOwner' : (context) => paymentMethodAddOwner(),
          '/showParkingSlotDetailsOwner' : (context) => parkingSlotDetailsOwner(),
          '/addParkingPlaceOwner': (context) => addParkingPlaceOwner(),
          '/addParkingPlaceDetailsOwner': (context) => addParkingPlaceDetailsOwner(),
          '/addParkingSlotOwner': (context) => addParkingSlotOwner()
        },
      )
  );
}



