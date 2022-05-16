import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/secondary_pages/authentication.dart';
import 'package:flutter_project_2022/pages/secondary_pages/wrapper.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  // coded class with help from - https://www.youtube.com/watch?v=TLGe44gaEUM&list=LL&index=2&ab_channel=AndyJulow
  // instance of firebase auth to get the user
  final _auth = FirebaseAuth.instance;

  // user variable
  User? user;
  // timer variable
  Timer? timer;

  @override
  void initState() {
    // set the currentuser to user
    user = _auth.currentUser;

    // send a email to the user to verify address
    user?.sendEmailVerification();

    // ping every five seconds to check if email is verified
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // check if verified
      CheckVerification();
    });
    super.initState();
  }

  // call dispose method to make sure timer is cancelled
  @override
  void dispose() {
    // cancel timer
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: new Text("Email Verification"),
      ),
      body: Container(
        width: width,
        child: Column(
          children: <Widget>[
            // sized box to space out fields
            SizedBox(
              height: 220.0,
            ),

            // output text letting user know an email has been sent
            Text('Sent an email to ${user?.email} please verify', textAlign: TextAlign.center,),

            // sized box to space out fields
            SizedBox(
              height: 100.0,
            ),

            // add a button to escape this screen in the event of a invalid email being entered
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
                primary: Colors.white,
                alignment: Alignment.center
              ),
              onPressed: () {
                // send user back to authentication pages
                Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => Authentication()));
              },
              child: const Text('Wrong email?, Click Here!'),
            ),
          ]
        )
      )
    );
  }

  // future method checkverification to check if email has been verified
  Future<void> CheckVerification() async {
    // get the user
    user = _auth.currentUser;
    // reload the user
    await user?.reload();
    // check if email is verified
    if (user!.emailVerified) {
      // cancel the timer
      timer?.cancel();
      // navigate to the wrapper which sends the user to the main pages
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
    }
  }
}
