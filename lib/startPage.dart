import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wan/GoogleFiles/google_sign_in.dart';
import 'package:e_wan/homePageController.dart';
import 'package:e_wan/parkingLocation.dart';
import 'package:e_wan/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class startPage extends StatefulWidget {

  @override
  State<startPage> createState() => _homePageState();

}

class _homePageState extends State<startPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: SingleChildScrollView(
                    child:
                      Stack(
                    children: [
                      Positioned(
                          top: 13,
                          left: 20,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(28),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Ink.image(
                                      image: NetworkImage(user.photoURL!),
                                      height: 30 ,
                                      width: 30,
                                      fit: BoxFit.cover,
                                      child: InkWell(
                                        splashColor: const Color(0xfffcb631),
                                        onTap: (){
                                          showDialog(context: context, builder: (context) => showProfile());
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8,),
                              Text(user.displayName!, style:
                              const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.black
                              ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width-220,
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                          provider.logout();
                                        },
                                        child:
                                        const Text('Logout', style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),)
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      //PARKING NAME
                      Positioned(
                        child:Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff252626),
                          ),
                          margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                          height: 130,
                          child: Padding(
                              padding: const EdgeInsets.all(15), //apply padding to all four sides
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Column(
                                          children: const [
                                            Text("CHOOSE A", style:
                                            TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Metropolis",
                                                fontWeight: FontWeight.w500
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Column(
                                          children: const [
                                            Text("PARKING", style:
                                            TextStyle(
                                                fontSize: 30,
                                                color: Color(0xfff8d73a),
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
                                                fontSize: 30,
                                                color: Color(0xfff8d73a),
                                                fontFamily: "Metropolis",
                                                fontWeight: FontWeight.w900
                                            ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/parkingLocation');
                                    },
                                  )
                              )
                          ),
                        ),
                      ),

                      //TRANSACTIONS
                      Positioned(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff5d6974),
                          ),
                          margin: const EdgeInsets.only(top: 250, left: 20, right: 20),
                          height: 450,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20, right: 15), //apply padding to all four sides
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Text("TRANSACTIONS", style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1,
                                          fontSize: 20,
                                          color: Colors.white,
                                      ),)
                                    ],
                                  ),
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
                                              const Text("ACTIVE", style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8
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
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                height: 10,
                                                width: 10,
                                              ),
                                              const SizedBox(width: 3),
                                              const Text("PAST", style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8
                                              ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Column(
                                      children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 80,
                                    /*height: MediaQuery.of(context).size.height - 420,*/
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                                .collection('userData')
                                                .doc(user.uid)
                                                .collection("Transactions").orderBy('DateAndTime', descending: true)
                                                .snapshots(),
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
                                                  DateTime dt = (documentSnapshot["DateAndTime"] as Timestamp).toDate();
                                                  var date = DateFormat('MM/dd/yyyy').format(dt);
                                                  var time = DateFormat('hh:mm a').format(dt);
                                                  return Column(
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.black,
                                                            onPrimary: Colors.black,
                                                            /*minimumSize: Size(MediaQuery.of(context).size.width-20, 70),*/
                                                          ),onPressed: (){
                                                            Navigator.pushNamed(context, '/transactionDetails', arguments: {
                                                              'transactionIndex': index
                                                            });
                                                        },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 10,),
                                                              Row(
                                                                children: [
                                                                  Text(documentSnapshot["ParkingLocationName"], style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 20
                                                                  ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(date, style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 12
                                                                  ),),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(time, style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 12
                                                                  ),),
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
                      )
                    ],
                  )
               )
            )
        )
    );
  }
}


class showProfile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  //showProfile({userName, emailAddress, userProfilePicture});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              top: 150,
              bottom: 16,
              left: 16,
              right: 16
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0)
                )
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                user.displayName!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 1,),
              Text(
                user.email!,
                style: const TextStyle(
                    fontSize: 15
                ),
              ),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 60,
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(100),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Ink.image(
              image: NetworkImage(user.photoURL!),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
              child: InkWell(
                splashColor: const Color(0xfffcb631),
                onTap: (){
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

