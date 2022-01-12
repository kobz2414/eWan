import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class transactionDetails extends StatefulWidget {
  const transactionDetails({Key? key}) : super(key: key);

  @override
  _transactionDetailsState createState() => _transactionDetailsState();
}

class _transactionDetailsState extends State<transactionDetails> {

  String transactionID = "SME01007202200001";
  String dateAndTime = "JANUARY 07, 2022";
  String parkingArea = "SM ECOLAND";
  String parkingSlot = "SME001";
  String status = "Pending";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6fbff),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text("TRANSACTION ID", style: TextStyle(
                              color: Color(0xff5d6974),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                          ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(transactionID, style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                          )
                        ],
                      ),
                      //DATE AND TIME
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
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
                          Text(dateAndTime, style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                          )
                        ],
                      ),
                      //PARKING AREA
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
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
                          Text(parkingArea, style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                          )
                        ],
                      ),
                      //PARKING SLOT
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
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
                          Text(parkingSlot, style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                          )
                        ],
                      ),
                      //STATUS
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
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
                          Text(status, style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20
                          ),
                          )
                        ],
                      ),
                      SizedBox(
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
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0)
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
                                onPressed: (){},
                                child: Text("CANCEL", style: TextStyle(
                                       fontWeight: FontWeight.bold
                                   ),
                                ),
                                style: ElevatedButton.styleFrom(
                                         primary: Colors.white,
                                         onPrimary: Colors.black,
                                         minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                         shape: new RoundedRectangleBorder(
                                             borderRadius: new BorderRadius.circular(30.0)
                                         )
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            )
        ),
      ),
    );
  }
}
