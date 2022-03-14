import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class paymentDetails extends StatefulWidget {
  const paymentDetails({Key? key}) : super(key: key);

  @override
  State<paymentDetails> createState() => _paymentDetailsState();
}

class _paymentDetailsState extends State<paymentDetails> {

  TextEditingController paymentMethod = TextEditingController();
  TextEditingController sender = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController referenceNumber = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final database = FirebaseDatabase.instance.reference();
  var data;
  var dbTransactions;

  Map args = {};

  @override
  Widget build(BuildContext context) {

    args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff5d6974),
                ),
                height: 500,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 15), //apply padding to all four sides
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text("SEND PAYMENT DETAILS", style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              fontSize: 20,
                              color: Colors.white,
                            ),)
                          ],
                        ),
                        const SizedBox(height: 25),
                        Column(
                            children: [
                              Row(
                                children: const [
                                  Text('TRANSACTION ID', style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(args["transactionNumber"].toString(), style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16
                                  ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                //height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height - 420 : MediaQuery.of(context).size.height - 80,
                                child: Column(
                                    children: [
                                      TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: paymentMethod,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 1),
                                          ),
                                          labelText: 'Payment Method',
                                          hintText: 'Enter Payment Method',
                                          hintStyle: TextStyle(color: Colors.white38),
                                          labelStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,),
                                      TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: sender,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 1),
                                          ),
                                          labelText: 'Sender\'s Name',
                                          hintText: 'Enter Sender\'s Name',
                                          hintStyle: TextStyle(color: Colors.white38),
                                          labelStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,),
                                      TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: amount,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 1),
                                          ),
                                          labelText: 'Amount',
                                          hintText: 'Enter Amount Paid',
                                          hintStyle: TextStyle(color: Colors.white38),
                                          labelStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,),
                                      TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: referenceNumber,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white, width: 1),
                                          ),
                                          labelText: 'Reference Number',
                                          hintText: 'Enter Reference Number',
                                          hintStyle: TextStyle(color: Colors.white38),
                                          labelStyle: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  onPrimary: Colors.black,
                                                  minimumSize: Size(MediaQuery.of(context).size.width-150, 40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30.0)
                                                  )
                                              ),
                                              child: const Text('SUBMIT', style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              onPressed: (){
                                                insertPaymentDetails(paymentMethod.text, sender.text, amount.text, referenceNumber.text);
                                                Navigator.pushReplacementNamed(context, '/transactionDetails', arguments: {
                                                  'transactionNumber': args["transactionNumber"],
                                                });
                                              },
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
                                                  Navigator.pushReplacementNamed(context, '/transactionDetails', arguments: {
                                                    'transactionNumber': args["transactionNumber"],
                                                  });
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
                                      ),
                                    ]
                                ),
                              )
                            ]
                        )
                      ],
                    )
                ),
              ),
              const SizedBox(
                height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void insertPaymentDetails(String paymentMethod, String name, String amount, String referenceNumber) {

    database.child("PaymentDetails").child(args["transactionNumber"]).update({
      "TransactionID": args["transactionNumber"],
      "PaymentMethod": paymentMethod,
      "Name": name,
      "Amount": amount,
      "ReferenceNumber": referenceNumber,
    });
  }

}
