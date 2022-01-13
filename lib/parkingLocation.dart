import 'package:e_wan/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class parkingLocation extends StatefulWidget {
  const parkingLocation({Key? key}) : super(key: key);

  @override
  _parkingLocationState createState() => _parkingLocationState();
}

class _parkingLocationState extends State<parkingLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6fbff),
      body: SizedBox(
        //height: MediaQuery.of(context).size.height,
        //width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              //color: Colors.red,
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Column(
                    children: const [
                      Text("CHOOSE A", style:
                      TextStyle(
                          color: Colors.black,
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Column(
                    children: const [
                      Text("PARKING", style:
                      TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w900
                      ),
                      )
                    ],
                  ),
                  Column(
                    children: const [
                      Text("PLACE", style:
                      TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.w900
                      ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 320,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('ParkingLocation').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              var itemCount = snapshot.data?.docs.length ?? 0;
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }else {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: itemCount,
                                    itemBuilder: (context, index){
                                      DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                                      DateTime dt = (documentSnapshot["ParkingLocationLastUpdate"] as Timestamp).toDate();
                                      var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
                                      return Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.black,
                                              onPrimary: Colors.black,
                                              minimumSize: Size(MediaQuery.of(context).size.width-40, 70),
                                            ),onPressed: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => homePage(),
                                                )
                                            );
                                          },
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Column(
                                                  children: [
                                                    Text(documentSnapshot["ParkingLocationName"], style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20
                                                    ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Total: ' + documentSnapshot["ParkingLocationTotal"].toString(), style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12
                                                    ),),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Available: ' + documentSnapshot["ParkingLocationAvailable"].toString(), style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12
                                                    ),),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Column(
                                                  children: [
                                                    Text('LAST UPDATED: ' + d12.toString(), style:
                                                    const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontFamily: "Metropolis",
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10,)
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10,)
                                        ]
                                      );
                                    });

                                /*ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index){
                                      DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                            onPrimary: Colors.black,
                                            minimumSize: Size(MediaQuery.of(context).size.width-40, 70),
                                          ),
                                          onPressed: (){},
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(documentSnapshot.get(1), style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 23
                                                  ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Total', style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Available', style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12
                                                  ),),
                                                ],
                                              ),
                                            ],
                                          )
                                      );
                                    });*/
                              }
                            }
                        ),


                        /*Expanded(child: Column(
                          children: [
                            Column(
                              children: [

                              ],
                            ),
                          ],
                        ),)*/
                      )
                        /*StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('ParkingLocation').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if(!snapshot.hasData){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }else{
                              return;
                            }
                          },
                        ),*/
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );

    /*Stack(
        children: [
          Positioned(
              child: Container(
                margin: const EdgeInsets.only(bottom: 540),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  color: const Color(0xff262626),
                ),
              )
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: const [
                Text("CHOOSE A", style:
                TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w500
                ),
                )
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              children: const [
                Text("PARKING", style:
                TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w900
                ),
                )
              ],
            ),
          ),
          Positioned(
              top: 93,
              left: 20,
              child: Row(
                children: const [
                  Text("PLACE", style:
                  TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w900
                  ),
                  )
                ],
              )
          ),
          Positioned(
              top: 140,
              left: 20,
              child: Row(
                children: const [
                  Text("LAST UPDATED: 12:30 PM, JANUARY 07, 2022", style:
                  TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w900
                  ),
                  )
                ],
              )
          ),

        ]
    )*/


    //final ek
    /*Column(
      children: [
        Row(
          children: [
            Text('Text', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23
            ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Total', style: TextStyle(
                color: Colors.white,
                fontSize: 12
            ),),
          ],
        ),
        Row(
          children: [
            Text('Available', style: TextStyle(
                color: Colors.white,
                fontSize: 12
            ),),
          ],
        ),
      ],
    )*/


    /*Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ParkingLocation').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return
          }
        },
      ),
    );*/

  }
}