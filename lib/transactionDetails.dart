import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class transactionDetails extends StatefulWidget {
  const transactionDetails({Key? key}) : super(key: key);

  @override
  _transactionDetailsState createState() => _transactionDetailsState();
}

class _transactionDetailsState extends State<transactionDetails> {
  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  var data;
  var dbTransactions;
  var dbParkingSlotLoc;
  var ParkingSlotLocationLat, ParkingSlotLocationLong;

  Map args = {};

  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Color(0xfff6fbff),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: StreamBuilder(
                      stream: database.child("userData").child(user.uid).child("Transactions").child(args["transactionNumber"]).onValue,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }else {
                          data = (snapshot.data! as Event).snapshot.value;


                          return Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("TRANSACTION DETAILS", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20
                                    ),
                                    )
                                  ],
                                ),
                              ),
                              //TRANSACTION ID
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: const [
                                  Text('TRANSACTION ID', style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(args["transactionNumber"].toString(), style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //DATE AND TIME
                              const SizedBox(
                                height: 16,
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
                              //NAME
                              Row(
                                children: [
                                  Text(data["Name"].toString(), style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //EMAIL
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("Email", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["Email"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //CONTACT NUMBER
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("Mobile Number", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["MobileNumber"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //PARKING SLOT
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("Plate Number", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["PlateNumber"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              Row(
                                children: const [
                                  Text("Reserved Date and Time", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["RentTimeFrom"] + " - ", style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["RentTimeTo"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //PARKING AREA
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("PARKING AREA", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["ParkingLocationName"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //PARKING SLOT
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("PARKING SLOT", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["ParkingSlotID"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              //STATUS
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: const [
                                  Text("STATUS", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["RequestStatus"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                children: const [
                                  Text("Total Due", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data["TotalCost"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              //PAYMENT METHODS
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xff5d6974),
                                ),
                                height: 300,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 20, right: 15), //apply padding to all four sides
                                    child: Column(
                                      children: [
                                        Row(
                                          children: const [
                                            Text("PAYMENT METHODS", style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),)
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width - 80,
                                                height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height - 500 : MediaQuery.of(context).size.height - 160,
                                                child: StreamBuilder(
                                                    stream: database.child("PaymentMethods").child(data["ownerUID"]).onValue,
                                                    builder: (context, snapshot) {
                                                      if(snapshot.hasData){
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return const Center(
                                                            child: CircularProgressIndicator(),
                                                          );
                                                        } else if (snapshot.hasError) {
                                                          return const Text("Something went wrong");
                                                        }else{
                                                          dbTransactions = (snapshot.data! as Event).snapshot.value;

                                                          if(dbTransactions != null){
                                                            var entryList = dbTransactions.entries.toList();

                                                            return ListView.builder(
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                itemCount: dbTransactions.length,
                                                                itemBuilder: (context, index) {
                                                                  return Column(
                                                                      children: [
                                                                        ElevatedButton(
                                                                          style: ElevatedButton
                                                                              .styleFrom(
                                                                            primary: Colors.white,
                                                                            /*minimumSize: Size(MediaQuery.of(context).size.width-20, 70),*/
                                                                          ), onPressed: () {
                                                                          // Navigator.pushNamed(context, '/transactionDetails', arguments: {
                                                                          //   'transactionNumber': entryList[index].key
                                                                          // });
                                                                        },
                                                                          child: Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 10,),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    entryList[index].value["MethodName"],
                                                                                    style: const TextStyle(
                                                                                        color: Color(
                                                                                            0xff252626),
                                                                                        fontWeight: FontWeight
                                                                                            .bold,
                                                                                        fontSize: 18
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    entryList[index].value["AccountName"],
                                                                                    style: const TextStyle(
                                                                                        color: Color(
                                                                                            0xff252626),
                                                                                        fontSize: 12
                                                                                    ),),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    entryList[index].value["AccountNumber"],
                                                                                    style: TextStyle(
                                                                                        color: Color(
                                                                                            0xff252626),
                                                                                        fontSize: 12
                                                                                    ),),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 10,)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 10,)
                                                                      ]
                                                                  );
                                                                });
                                                          }else{
                                                            return Text("");
                                                          }
                                                        }
                                                      }else{
                                                        return Text("");
                                                      }
                                                    }
                                                ),
                                              )
                                            ]
                                        )
                                      ],
                                    )
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //PAYMENT DETAILS
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Color(0xff5d6974),
                                ),
                                height: 260,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 20, right: 15), //apply padding to all four sides
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Text("PAYMENT DETAILS", style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 1,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),)
                                          ],
                                        ),
                                        Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width - 80,
                                                //height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height - 500 : MediaQuery.of(context).size.height - 160,
                                                child: StreamBuilder(
                                                    stream: database.child("PaymentDetails").child(args["transactionNumber"]).onValue,
                                                    builder: (context, snapshot) {
                                                      if(snapshot.hasData){
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return const Center(
                                                            child: CircularProgressIndicator(),
                                                          );
                                                        } else if (snapshot.hasError) {
                                                          return const Text("Something went wrong");
                                                        }else{
                                                          dbTransactions = (snapshot.data! as Event).snapshot.value;

                                                          if(dbTransactions != null){

                                                            return Column(
                                                              children: [
                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Payment Method", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(dbTransactions["PaymentMethod"], style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Reference Number", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(dbTransactions["ReferenceNumber"], style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Sender\s Name", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(dbTransactions["Name"], style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Amount Paid", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(dbTransactions["Amount"], style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),

                                                              ],
                                                            );
                                                          }else{
                                                            return Column(
                                                              children: [
                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Payment Method", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Text("-", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Reference Number", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Text("-", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Sender\s Name", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Text("-", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),
                                                                Row(
                                                                  children: const [
                                                                    Text("Amount Paid", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 12
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: const [
                                                                    Text("-", style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 16
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(height: 18,),

                                                              ],
                                                            );
                                                          }
                                                        }
                                                      }else{
                                                        return const Text("");
                                                      }
                                                    }
                                                ),
                                              )
                                            ]
                                        )
                                      ],
                                    )
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //BUTTONS
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.black,
                                          minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                          )
                                      ),
                                      child: const Text('SEND PAYMENT DETAILS', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),),
                                      onPressed: data["RequestStatus"] == "Declined" || data["RequestStatus"] == "Approved" ? null : (){
                                        Navigator.pushNamed(context, '/paymentDetails', arguments: {
                                          'transactionNumber': args["transactionNumber"]
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.black,
                                          minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                          )
                                      ),
                                      child: const Text('REMOVE PAYMENT DETAILS', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),),
                                      onPressed: data["RequestStatus"] == "Declined" || data["RequestStatus"] == "Approved" ? null : (){
                                        database.child("PaymentDetails").child(args["transactionNumber"]).remove();
                                      },
                                    )
                                  ],
                                ),
                              ),StreamBuilder(
                                  stream: database.child("ParkingSlot").child(data["ParkingLocationName"]).child(data["ParkingSlotID"]).onValue,
                                  builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                      child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text("Something went wrong");
                                      }else{
                                        dbParkingSlotLoc = (snapshot.data! as Event).snapshot.value;

                                        if(dbParkingSlotLoc != null){
                                          ParkingSlotLocationLat = dbParkingSlotLoc["ParkingSlotLocationLat"];
                                          ParkingSlotLocationLong = dbParkingSlotLoc["ParkingSlotLocationLong"];
                                        }
                                      }
                                    }
                                  return SizedBox();
                                  }
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary: Colors.black,
                                          minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)
                                          )
                                      ),
                                      icon: const FaIcon(FontAwesomeIcons.mapMarked, color: Colors.black,),
                                      label: const Text('DIRECTIONS', style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),
                                      onPressed: data["RequestStatus"] == "Declined" || data["RequestStatus"] == "Pending" ? null : (){
                                        Navigator.pushReplacementNamed(context, '/googleMapsDirections', arguments: {
                                          'parkingSlotLocationLat': ParkingSlotLocationLat,
                                          'parkingSlotLocationLong': ParkingSlotLocationLong,
                                        });
                                        //MAPS
                                      },
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
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          );
                        }
                      }
                  ),
                ),
            )
        ),
      ),
    );
  }
}
