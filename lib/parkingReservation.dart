import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class parkingReservation extends StatefulWidget {
  const parkingReservation({Key? key}) : super(key: key);

  @override
  State<parkingReservation> createState() => _parkingReservationState();
}

class _parkingReservationState extends State<parkingReservation> {
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController plateNumber = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();
  var dbData;
  var parkingDetailsData;
  String parkingPrice = "", rentDurationFrom = "", rentDurationTo = "",rentFrom = "", rentTo = "";

  Map args = {};

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobileNumber.dispose();
    plateNumber.dispose();
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
                            Text("TRANSACTION DETAILS", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 25
                            ),),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Text("Please input the required details below for your parking reservation", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 10
                          ),),
                        ],
                      ),

                      // NAME
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: const [
                          Text('Name', style: TextStyle(
                              color: Color(0xff5d6974),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(user.displayName.toString(), style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          )
                        ],
                      ),

                      // EMAIL
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Text('Email', style: TextStyle(
                              color: Color(0xff5d6974),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(user.email.toString(), style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      //PARKING LOCATION
                      Row(
                        children: const [
                          Text('Parking Location', style: TextStyle(
                              color: Color(0xff5d6974),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(args["parkingLocationID"], style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      //PARKING SLOT
                      Row(
                        children: const [
                          Text('Parking Slot', style: TextStyle(
                              color: Color(0xff5d6974),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(args["parkingSlotID"], style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      StreamBuilder(
                          stream: databaseParking.child("ParkingLocation").child(args["parkingLocationID"]).onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            } else {
                              parkingDetailsData = (snapshot.data! as Event).snapshot.value;

                              rentTo = parkingDetailsData["RentTimeToFormatted"];
                              rentFrom = parkingDetailsData["RentTimeFromFormatted"];

                              DateTime dt1 = DateTime.parse(rentTo);
                              DateTime dt2 = DateTime.parse(rentFrom);

                              Duration diff = dt1.difference(dt2);
                              parkingPrice =  (int.parse(parkingDetailsData["RentPrice"]) * int.parse(diff.inHours.toString())).toString();
                              rentDurationFrom = parkingDetailsData["RentTimeFrom"];
                              rentDurationTo = parkingDetailsData["RentTimeTo"];

                              return Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text("Parking Date and Time", style: TextStyle(
                                          color: Color(0xff5d6974),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(parkingDetailsData["RentTimeFrom"]  + " - ", style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(parkingDetailsData["RentTimeTo"], style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    children: const [
                                      Text("Total Fee (Hourly rate)", style: TextStyle(
                                          color: Color(0xff5d6974),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(parkingPrice, style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                      ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }
                          }
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller: mobileNumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                          hintText: 'Enter Mobile Number',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: plateNumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Plate Number',
                          hintText: 'Enter Plate Number',
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      StreamBuilder(
                          stream: databaseParking.child("ParkingSlot").child(args["parkingLocationID"]).child(args["parkingSlotID"]).onValue,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }else{

                              dbData = (snapshot.data! as Event).snapshot.value;

                              return  Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: dbData["ArduinoStatus"] == "Not Available" || dbData["ArduinoStatus"] == "Occupied" || mobileNumber.text == "" || plateNumber.text == "" ? null : (){
                                              Navigator.pushReplacementNamed(context, '/parkingSlot', arguments: {
                                                'parkingLocationID': args["parkingLocationID"]
                                              });
                                              insertTransaction(mobileNumber.text, plateNumber.text);
                                            },
                                            child: const Text("RESERVE", style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff262626),
                                                onPrimary: Colors.white,
                                                minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30.0)
                                                )

                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: (){
                                              Navigator.pushReplacementNamed(context, '/parkingSlot', arguments: {
                                                'parkingLocationID': args["parkingLocationID"]
                                              });
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
                                  )
                                ],
                              );
                            }
                          }
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }


  void insertTransaction(String mobileNumber, String plateNumber) {
    final DateTime now = DateTime.now().toLocal();
    var currDate = DateFormat.yMMMMd('en_US').format(now);
    var currTime = DateFormat.jm().format(now);

    var currMonth = DateFormat('M').format(now);
    var currDateNum = DateFormat('d').format(now);
    var currYear = DateFormat('y').format(now);
    var curHour = DateFormat('H').format(now);
    var curMin = DateFormat('m').format(now);
    var currSec = DateFormat('s').format(now);

    String transactionNumber = 'ADDU' + currMonth.toString() + currDateNum.toString() + currYear.toString() + curHour.toString() + curMin.toString() + currSec.toString();

    databaseParking.child("UserData").child(user.uid).child("Transactions").child(transactionNumber).set({
      "RequestStatus": "Pending",
      "Date": currDate,
      "ParkingLocationName": args["parkingLocationID"],
      "ParkingSlotID": args["parkingSlotID"],
      "Time": currTime,
      "TransactionStatus": "Active",
      "Name": user.displayName,
      "Email": user.email,
      "MobileNumber": mobileNumber,
      "PlateNumber": plateNumber,
      "TotalCost": parkingPrice,
      "RentTimeFrom": rentDurationFrom,
      "RentTimeTo": rentDurationTo,
      "RentTimeFromFormatted": rentFrom,
      "RentTimeToFormatted": rentTo
    });

    databaseParking.child("Transactions").child(args["parkingLocationID"]).child(transactionNumber).set({
      "userID": user.uid,
      "RequestStatus": "Pending",
      "ParkingLocationName": args["parkingLocationID"],
      "ParkingSlotID": args["parkingSlotID"],
      "Date": currDate,
      "Time": currTime,
      "TransactionStatus": "Active",
      "Name": user.displayName,
      "Email": user.email,
      "MobileNumber": mobileNumber,
      "PlateNumber": plateNumber,
      "TotalCost": parkingPrice,
      "RentTimeFrom": rentDurationFrom,
      "RentTimeTo": rentDurationTo,
      "RentTimeFromFormatted": rentFrom,
      "RentTimeToFormatted": rentTo
    });
  }
}
