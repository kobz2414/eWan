import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class parkingSlot extends StatefulWidget {
  const parkingSlot({Key? key}) : super(key: key);

  @override
  State<parkingSlot> createState() => _parkingSlotState();
}

class _parkingSlotState extends State<parkingSlot> {

  final user = FirebaseAuth.instance.currentUser!;
  final databaseParking = FirebaseDatabase.instance.reference();

  var dbData;
  int availableParkingSpaces = 10;
  int totalParkingSpaces = 10;
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
                stream: databaseParking.child("ParkingSlot").child(parkingLocationID).onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }else{

                    final DateTime now = DateTime.now();
                    var currDate = DateFormat('MM/dd/yyyy').format(now);
                    var currTime = DateFormat('hh:mm:ss a').format(now.subtract(Duration( hours: 4 )));

                    dbData = (snapshot.data! as Event).snapshot.value;
                    var entryList = dbData.entries.toList();

                    if(dbData != null){
                      totalParkingSpaces =  dbData.length;
                    }

                    int occupied = 0;
                    int vacant = 0;

                    for(int x = 0; x < totalParkingSpaces; x++ ){
                      if(entryList[x].value["ArduinoStatus"] != "Vacant" ){
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
                              height: 150,
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
                                        Text(parkingLocationID, style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                          color: Color(0xff252525),
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text("LAST UPDATED", style: const TextStyle(
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
                                    )
                                  ],
                                ),
                              )
                          ),
                          Positioned(
                              right: 80,
                              child:
                              Container(
                                margin: const EdgeInsets.only(top: 50, left: 35, right: 20),
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
                                      children: [
                                        (totalParkingSpaces > 0 && totalParkingSpaces < 20) ?
                                        Text(totalParkingSpaces.toString(), style: const TextStyle(
                                          color: Color(0xff252525),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -3,
                                        ),) :
                                        Text(totalParkingSpaces.toString(), style: const TextStyle(
                                          color: Color(0xff252525),
                                          fontSize: 25,
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
                                margin: const EdgeInsets.only(top: 50, left: 35, right: 20),
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
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: -3,
                                        ),) :
                                        Text(availableParkingSpaces.toString(), style: const TextStyle(
                                          color: Color(0xff252525),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0,
                                        ),),
                                      ],
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
                              children: [
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
                                              color: Color(0xfff6fbff),
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
                          Positioned(
                              child:
                              Container(
                                margin: const EdgeInsets.only(top: 190, left: 20, right: 20, bottom: 40),
                                child: SingleChildScrollView(
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child:  Stack(
                                        children: [
                                          //PARKING SLOTS 16-24
                                          Positioned(
                                            left: 80,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 105,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 130,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 155,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 180,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 205,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 230,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 255,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            left: 280,
                                            child: SizedBox(
                                              width: 20,
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          //PARKING SLOTS 1-7
                                          Positioned(
                                            top: 35,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 60,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 85,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 110,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 135,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 160,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 185,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          //PARKING SLOTS 8-15
                                          Positioned(
                                            top: 250,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 275,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 300,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 325,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 350,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 375,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                          Positioned(
                                            top: 400,
                                            left: 305,
                                            child: SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color(0xff5d6974),
                                                  onPrimary: const Color(0xff5d6974),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                ), onPressed: () {},
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
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              )
                          )
                        ]
                    );
                  }
                }
            ),
        ),
      ),
    );
  }
}

