import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addParkingSlotOwner extends StatefulWidget {
  const addParkingSlotOwner({Key? key}) : super(key: key);

  @override
  State<addParkingSlotOwner> createState() => _addParkingSlotOwnerState();
}

class _addParkingSlotOwnerState extends State<addParkingSlotOwner> {
  TextEditingController numberOfSlots = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();

  Map args = {};

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    numberOfSlots.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;

    return Scaffold(
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
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
                        Text("PARKING SLOT DETAILS", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 25
                        ),),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Text("Please input the required details below",
                        style: TextStyle(
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
                    controller: numberOfSlots,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '# of Parking Slots',
                      hintText: 'Enter Parking Slots #',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  ElevatedButton(
                      onPressed: () {
                        addNewSlots(args["parkingLocationID"].toString(), args["parkingLat"], args["parkingLong"], numberOfSlots.text);
                        Navigator.pop(context);
                      },
                      child: const Text("SUBMIT", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(MediaQuery
                              .of(context)
                              .size
                              .width - 150, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          )
                      )
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("CANCEL", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          minimumSize: Size(MediaQuery
                              .of(context)
                              .size
                              .width - 150, 40),
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

  void addNewSlots(String parkingName, double parkingLocLat, double parkingLocLng, String parkingSlotsNum){
    final DateTime now = DateTime.now().toLocal();

    var currMonth = DateFormat('M').format(now);
    var currDateNum = DateFormat('d').format(now);
    var currYear = DateFormat('y').format(now);
    var curHour = DateFormat('H').format(now);
    var curMin = DateFormat('m').format(now);
    var currSec = DateFormat('s').format(now);

    String transactionNumber = parkingName + " " + currMonth.toString() + currDateNum.toString() + currYear.toString() + curHour.toString() + curMin.toString() + currSec.toString();


    databaseParking.child("Requests").child("AdditionalSlots").child(transactionNumber).set({
      "requestedBy": user.displayName,
      "requestedByEmail": user.email,
      "parkingLocLat": parkingLocLat,
      "parkingLocLng": parkingLocLng,
      "parkingName": parkingName,
      "parkingSlotsNum": parkingSlotsNum
    });
  }

}
