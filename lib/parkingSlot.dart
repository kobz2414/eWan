import 'package:flutter/material.dart';

class parkingSlot extends StatelessWidget {
  const parkingSlot({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    int availableParkingSpaces = 10;
    int totalParkingSpaces = 10;

    return Scaffold(
      backgroundColor: Color(0xff262626),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: Stack(
                children: [
                  Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 590),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                          color: const Color(0xfff6fbff),
                        ),
                      )
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Row(
                      children: const [
                        Text("PARKING LOCATION", style:
                        TextStyle(
                            fontSize: 10,
                            color: Color(0xff262626),
                            fontFamily: "Metropolis",
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
                        Text("SM ECOLAND", style:
                        TextStyle(
                            fontSize: 25,
                            color: Color(0xff262626),
                            fontFamily: "Metropolis",
                            fontWeight: FontWeight.w800
                        ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 90,
                      left: 20,
                      child: Row(
                        children: const [
                          Text("LAST UPDATED: 12:30 PM, JANUARY 07, 2022", style:
                          TextStyle(
                              fontSize: 8,
                              color: Color(0xff262626),
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.w700
                          ),
                          )
                        ],
                      )
                  ),
                  Positioned(
                      top: 35,
                      left: 260,
                      child:
                        Row(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 8),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              child: Row(
                                                children: const [
                                                  Text("TOTAL", style: TextStyle(
                                                    color: const Color(0xff262626),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 23, left: 8),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                child: Row(
                                                  children: [
                                                    (totalParkingSpaces > 0 && totalParkingSpaces < 20) ?
                                                    Text(totalParkingSpaces.toString(), style: const TextStyle(
                                                      color: const Color(0xff262626),
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.w800,
                                                      letterSpacing: -1,
                                                    ),) :
                                                    Text(totalParkingSpaces.toString(), style: const TextStyle(
                                                      color: const Color(0xff262626),
                                                      fontSize: 60,
                                                      fontWeight: FontWeight.w800,
                                                      letterSpacing: 0,
                                                    ),),
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 20),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              child: Row(
                                                children: const [
                                                  Text("AVAILABLE", style: TextStyle(
                                                    color: const Color(0xff262626),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 25, left: 20),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                child: Row(
                                                  children: [
                                                    (availableParkingSpaces > 0 && availableParkingSpaces < 20) ?
                                                    Text(availableParkingSpaces.toString(), style: const TextStyle(
                                                      color: const Color(0xff262626),
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.w800,
                                                      letterSpacing: -1,
                                                    ),) :
                                                    Text(availableParkingSpaces.toString(), style: const TextStyle(
                                                      color: const Color(0xff262626),
                                                      fontSize: 60,
                                                      fontWeight: FontWeight.w800,
                                                      letterSpacing: 0,
                                                    ),),
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                  ),
                  Positioned(
                    bottom: 30,
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
                  )
              ]
            )
        ),
      ),
    );
  }
}

