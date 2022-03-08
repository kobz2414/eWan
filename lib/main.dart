import 'package:e_wan/GoogleFiles/google_sign_in.dart';
import 'package:e_wan/homePageController.dart';
import 'package:e_wan/parkingLocation.dart';
import 'package:e_wan/parkingReservation.dart';
import 'package:e_wan/parkingSlot.dart';
import 'package:e_wan/showParkingSlotDetails.dart';
import 'package:e_wan/startPage.dart';
import 'package:e_wan/transactionDetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_wan/signIn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:e_wan/homePage.dart';

import 'ParkingAreas/parkingArea1.dart';

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
        },
      )
  );
}



