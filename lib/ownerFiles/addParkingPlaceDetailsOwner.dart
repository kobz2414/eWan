import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class addParkingPlaceDetailsOwner extends StatefulWidget {
  const addParkingPlaceDetailsOwner({Key? key}) : super(key: key);

  @override
  State<addParkingPlaceDetailsOwner> createState() => _addParkingPlaceDetailsOwnerState();
}

class _addParkingPlaceDetailsOwnerState extends State<addParkingPlaceDetailsOwner> {
  TextEditingController parkingName = TextEditingController();
  TextEditingController numberOfSlots = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();

  Map args = {};

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    parkingName.dispose();
    numberOfSlots.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child:
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Text("PARKING PLACE DETAILS", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Text("Please input the required details below", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10
                      ),),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  TextField(
                    controller: parkingName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Parking Name',
                      hintText: 'Enter Parking Name',
                    ),

                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: numberOfSlots,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '# of Parking Slots',
                      hintText: 'Enter Parking Slots #',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        addNewParkingPlace(parkingName.text, args["parkingLocationLat"], args["parkingLocationLng"],numberOfSlots.text);
                        Navigator.pop(context);
                      },
                      child: const Text("SUBMIT", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          )
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("CANCEL", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addNewParkingPlace(String parkingName, double parkingLocLat, double parkingLocLng, String parkingSlotsNum){
    final DateTime now = DateTime.now().toLocal();

    var currMonth = DateFormat('M').format(now);
    var currDateNum = DateFormat('d').format(now);
    var currYear = DateFormat('y').format(now);
    var curHour = DateFormat('H').format(now);
    var curMin = DateFormat('m').format(now);
    var currSec = DateFormat('s').format(now);

    String transactionNumber = parkingName + " " + currMonth.toString() + currDateNum.toString() + currYear.toString() + curHour.toString() + curMin.toString() + currSec.toString();

    databaseParking.child("Requests").child("ParkingPlace").child(transactionNumber).set({
      "uid": user.uid,
      "requestedBy": user.displayName,
      "requestedByEmail": user.email,
      "parkingName": parkingName,
      "parkingLocLat": parkingLocLat,
      "parkingLocLng": parkingLocLng,
      "parkingSlotsNum": parkingSlotsNum
    });
  }
}
