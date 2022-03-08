import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class parkingReservation extends StatefulWidget {
  const parkingReservation({Key? key}) : super(key: key);

  @override
  State<parkingReservation> createState() => _parkingReservationState();
}

class _parkingReservationState extends State<parkingReservation> {
  TextEditingController name = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController plateNumber = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();
  var dbData;

  Map args = {};

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    name.dispose();
    userEmail.dispose();
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
                      //TRANSACTION ID
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: name,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: user.displayName,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: userEmail,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: user.email,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: mobileNumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                          hintText: 'Enter Mobile Number',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: plateNumber,
                        decoration: InputDecoration(
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
                                            onPressed: dbData["ArduinoStatus"] == "Not Available" || dbData["ArduinoStatus"] == "Occupied" ? null : (){
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
      "TransactionType": args["parkingType"],
      "Name": user.displayName,
      "Email": user.email,
      "MobileNumber": mobileNumber,
      "PlateNumber": plateNumber
    });
  }
}
