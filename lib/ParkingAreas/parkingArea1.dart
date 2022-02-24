import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class parkingArea1 extends StatefulWidget {
  const parkingArea1({Key? key}) : super(key: key);

  @override
  _parkingArea1State createState() => _parkingArea1State();
}

class _parkingArea1State extends State<parkingArea1> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff252525),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: SingleChildScrollView(
                    child:
                    Stack(
                      children: [
                        //PARKING NAME
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
                                        children: const [
                                          Text("SM ECOLAND", style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 25,
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
                                          Text('currDate + " " + currTime', style: const TextStyle(
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
                                    children: const [
                                      Text("14", style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Color(0xff252525),
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
                                    children: const [
                                      Text("14", style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Color(0xff252525),
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}
