import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_wan/ownerFiles/startPageOwner.dart';
import 'package:e_wan/startPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GoogleFiles/google_sign_in.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({Key? key}) : super(key: key);

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {

  final List<String> accountType = [
    'Guest',
    'Owner',
  ];

  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  var userRole;
  String selectedUserRole = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: database.child("userData").child(user.uid).onValue,
        builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text("Something went wrong");
        }else{
          userRole = (snapshot.data! as Event).snapshot.value;

          if(userRole == null){
            return Scaffold(
                body: SafeArea(
                    child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width-50,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Welcome", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 50
                                )),
                              const SizedBox(height: 30,),
                              const Text("Please select your account type"),
                              const SizedBox(height: 10,),
                              DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text("Select",
                                  style: TextStyle(fontSize: 13),
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 20,
                                buttonHeight: 40,
                                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: accountType
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                onChanged: (userRole){
                                  selectedUserRole = userRole.toString();
                                },
                              ),
                              const SizedBox(height: 50,),
                              ElevatedButton(
                                  onPressed: (){
                                    insertNewUser();
                                  },
                                  child: const Text("Accept", style: TextStyle(
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
                    )
                )
            );
          }
          else{
            if(userRole["userRestricted"] == "False"){
              if(userRole["userRole"] == "Guest"){
                return startPage();
              }else{
                return startPageOwner();
              }
            }else{
              return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width-50,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Blocked", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 50
                      )),
                      const SizedBox(height: 10,),
                      const Text("Sorry. Your account is blocked."),
                      const SizedBox(height: 50,),
                      ElevatedButton(
                          onPressed: (){
                            final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                            provider.logout();
                          },
                          child: const Text("Logout", style: TextStyle(
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
                  ));
            }
          }
        }
    });
  }

  void insertNewUser(){
    database.child("userData").child(user.uid).set({
      "userName": user.displayName,
      "userEmail": user.email,
      "userRole": selectedUserRole,
      "userRestricted": "False",
    });

  }
}
