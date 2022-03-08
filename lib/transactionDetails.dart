import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class transactionDetails extends StatefulWidget {
  const transactionDetails({Key? key}) : super(key: key);

  @override
  _transactionDetailsState createState() => _transactionDetailsState();
}

class _transactionDetailsState extends State<transactionDetails> {
  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  var data;

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
                      stream: database.child("UserData").child(user.uid).child("Transactions").onValue,
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
                                height: 50,
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
                                  Text(args["transactionNumber"].toString(), style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  )
                                ],
                              ),
                              //DATE AND TIME
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: const [
                                  Text("DATE AND TIME", style: TextStyle(
                                      color: Color(0xff5d6974),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(data[args["transactionNumber"]]["Date"] + " - " + data[args["transactionNumber"]]["Time"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  )
                                ],
                              ),
                              //PARKING AREA
                              const SizedBox(
                                height: 25,
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
                                  Text(data[args["transactionNumber"]]["ParkingLocationName"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  )
                                ],
                              ),
                              //PARKING SLOT
                              const SizedBox(
                                height: 25,
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
                                  Text(data[args["transactionNumber"]]["ParkingSlotID"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  )
                                ],
                              ),
                              //STATUS
                              const SizedBox(
                                height: 25,
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
                                  Text(data[args["transactionNumber"]]["RequestStatus"], style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xfff8d73a),
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
                                      onPressed: (){},
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
                              )
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
