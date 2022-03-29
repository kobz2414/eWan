import 'package:e_wan/signIn.dart';
import 'package:e_wan/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePageController extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }else if (snapshot.hasData){
          return welcomePage();
        }else if (snapshot.hasError){
          return Center(child: const Text('Something went wrong!'));
        }else{
          return signIn();
        }
      },
    ),
  );
}
