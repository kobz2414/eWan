import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class parkingSlotOwner extends StatefulWidget {
  const parkingSlotOwner({Key? key}) : super(key: key);

  @override
  State<parkingSlotOwner> createState() => _parkingSlotState();
}

class _parkingSlotState extends State<parkingSlotOwner> {

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();

  var dbData1;
  var dbData2;
  var data;
  int availableParkingSpaces = 0;
  int totalParkingSpaces = 0;
  Map args = {};

  @override
  Widget build(BuildContext context) {


    args = ModalRoute.of(context)!.settings.arguments as Map;
    var parkingLocationID = args["parkingLocationID"];

    return Scaffold(
      backgroundColor: Color(0xff262626),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: StreamBuilder(
                stream: databaseParking.child("ParkingLocation").child(parkingLocationID).onValue,
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot1.hasError) {
                    return const Text("Something went wrong");
                  }else{
                    dbData1 = (snapshot1.data! as Event).snapshot.value;

                    return StreamBuilder(
                        stream: databaseParking.child("ParkingSlot").child(parkingLocationID).onValue,
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot2.hasError) {
                            return const Text("Something went wrong");
                          }else{

                            final DateTime now = DateTime.now();
                            var currDate = DateFormat('MM/dd/yyyy').format(now);
                            var currTime = DateFormat('hh:mm:ss a').format(now.subtract(const Duration( hours: 4)));

                            dbData2 = (snapshot2.data! as Event).snapshot.value;
                            var entryList2 = dbData2.entries.toList();


                            if(dbData2 != null){
                              totalParkingSpaces =  dbData2.length;
                            }

                            int occupied = 0;

                            for(int x = 0; x < totalParkingSpaces; x++ ){
                              if(entryList2[x].value["ArduinoStatus"] != "Vacant" ){
                                occupied += 1;
                              }
                            }

                            availableParkingSpaces = totalParkingSpaces - occupied;

                            //availableParkingSpaces = int.parse(data[args['parkingLocationID']]["ParkingLocationAvailable"].toString());

                            return Stack(
                                children: [
                                  Positioned(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                      height: 130,
                                      child: Padding(
                                          padding: const EdgeInsets.only(top: 15, left: 20, right: 15), //apply padding to all four sides
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              child:
                                              Column(children: const [
                                                Text("CHOOSE A SPOT", style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff252525),
                                                ),),
                                              ],)
                                          )
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      child:
                                      Container(
                                        margin: const EdgeInsets.only(top: 50, left: 35, right: 20),
                                        child:
                                        Column(
                                          children: [
                                            const SizedBox(height: 25,),
                                            Row(
                                              children: const [
                                                Text("PARKING LOCATION", style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                  color: Color(0xff252525),
                                                ),),
                                              ],
                                            ),
                                            Row(
                                              children:[
                                                Text(parkingLocationID, style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 15,
                                                  color: Color(0xff252525),
                                                ),),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: const [
                                                Text("LAST UPDATED", style: TextStyle(
                                                    color: Color(0xff252525),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10
                                                ),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(currDate + " " + currTime, style: const TextStyle(
                                                    color: Color(0xff252525),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10
                                                ),)
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Positioned(
                                      right: 80,
                                      child:
                                      Container(
                                        margin: const EdgeInsets.only(top: 50, left: 35, right: 5),
                                        child:
                                        Column(
                                          children: [
                                            const SizedBox(height: 25,),
                                            Row(
                                              children: const [
                                                Text("Total", style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                  color: Color(0xff252525),
                                                ),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                (totalParkingSpaces > 0 && totalParkingSpaces < 20) ?
                                                Text(totalParkingSpaces.toString(), style: const TextStyle(
                                                  color: Color(0xff252525),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: -3,
                                                ),) :
                                                Text(totalParkingSpaces.toString(), style: const TextStyle(
                                                  color: Color(0xff252525),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0,
                                                ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Positioned(
                                      right: 20,
                                      child:
                                      Container(
                                        margin: const EdgeInsets.only(top: 50, left: 35, right: 10),
                                        child:
                                        Column(
                                          children: [
                                            const SizedBox(height: 25,),
                                            Row(
                                              children: const [
                                                Text("Available", style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                  color: Color(0xff252525),
                                                ),),
                                              ],
                                            ),
                                            Row(
                                              children:[

                                                (availableParkingSpaces > 0 && availableParkingSpaces < 20) ?
                                                Text(availableParkingSpaces.toString(), style: const TextStyle(
                                                  color: Color(0xff252525),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: -3,
                                                ),) :
                                                Text(availableParkingSpaces.toString(), style: const TextStyle(
                                                  color: Color(0xff252525),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 0,
                                                ),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  Positioned(
                                      right: 80,
                                      child:
                                      Container(
                                        margin: const EdgeInsets.only(top: 85, left: 35, right: 5),
                                        child:
                                        Column(
                                          children: [
                                            const SizedBox(height: 25,),
                                            Row(
                                              children: const [
                                                Text("PARKING TYPE", style: TextStyle(
                                                    color: Color(0xff252525),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10
                                                ),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(dbData1["ParkingType"], style: const TextStyle(
                                                    color: Color(0xff252525),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10
                                                ),)
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),Positioned(
                                      bottom: 40,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pushNamed(context, '/addParkingSlotOwner', arguments: {
                                                    'parkingLocationID': parkingLocationID,
                                                    'parkingLat': dbData1["parkingLat"],
                                                    'parkingLong': dbData1["parkingLong"]
                                                  });
                                                  //addNewParkingPlace(parkingName.text, args["parkingLocationLat"].toString(), args["parkingLocationLng"].toString() ,numberOfSlots.text);
                                                  //Navigator.pop(context);
                                                },
                                                child: const Text("ADD PARKING SLOTS", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  fontSize: 12
                                                ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                    onPrimary: Colors.black,
                                                    minimumSize: Size(MediaQuery.of(context).size.width-180, 35),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30.0)
                                                    )
                                                )
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  // Labels Below
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xfff6fbff),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: 10,
                                                  width: 10,
                                                ),
                                                const SizedBox(width: 3),
                                                const Text("VACANT", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                    color: Colors.white
                                                ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 12,),
                                        Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xfff8d73a),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: 10,
                                                  width: 10,
                                                ),
                                                const SizedBox(width: 3),
                                                const Text("OCCUPIED", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                    color: Colors.white
                                                ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 12,),
                                        Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xffFDB827),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: 10,
                                                  width: 10,
                                                ),
                                                const SizedBox(width: 3),
                                                const Text("RESERVED", style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 12,),
                                        Column(
                                          children: [
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xff5d6974),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  height: 10,
                                                  width: 10,
                                                ),
                                                const SizedBox(width: 3),
                                                const Text("NOT AVAILABLE", style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  //Parking Slot Grp
                                  Positioned(
                                      child:
                                      Container(
                                        margin: const EdgeInsets.only(top: 170, left: 20, right: 20, bottom: 100),
                                        child: Container(
                                            height: MediaQuery.of(context).size.height + 100,
                                            width: MediaQuery.of(context).size.width,
                                            child: StreamBuilder(
                                                stream: databaseParking.child("ParkingSlot").child(parkingLocationID).onValue,
                                                builder: (context, snapshot2){
                                                  if (snapshot2.connectionState == ConnectionState.waiting) {
                                                    return const Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  } else if (snapshot2.hasError) {
                                                    return const Text("Something went wrong");
                                                  }else{
                                                    data = (snapshot2.data! as Event).snapshot.value;

                                                    if(data != null){
                                                      var entryList = data.entries.toList();

                                                      return ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: data.length,
                                                          itemBuilder: (context, index){
                                                            return Column(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 40,
                                                                    height: 25,
                                                                    child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary: entryList[index].value["ArduinoStatus"] == "Vacant" ?
                                                                        const Color(0xfff6fbff) : entryList[index].value["ArduinoStatus"] == "Occupied" ?
                                                                        const Color(0xfff8d73a) : entryList[index].value["ArduinoStatus"] == "Reserved" ?
                                                                        const Color(0xffFDB827) : const Color(0xff5d6974),
                                                                        onPrimary: const Color(0xff5d6974),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(3)
                                                                        ),
                                                                      ), onPressed: () {
                                                                      Navigator.pushNamed(context, '/showParkingSlotDetailsOwner', arguments: {
                                                                        'parkingSlotID': entryList[index].key,
                                                                        'parkingLocationID': parkingLocationID,
                                                                        'parkingType': dbData1["ParkingType"]
                                                                      });
                                                                    },
                                                                      child: Column(
                                                                        children: [
                                                                          Column(
                                                                            children: const [
                                                                              Text("", style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 10
                                                                              ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 5,)
                                                                ]
                                                            );
                                                          });
                                                    }
                                                    else{
                                                      return SizedBox();
                                                    }
                                                  }
                                                }
                                            )
                                        )
                                      )
                                  )
                                ]
                            );
                          }
                        }
                    );
                  }
                }
            ),
        ),
      ),
    );
  }
}

