import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/registerPage.dart';
import 'package:flutter_project_2022/pages/signInPage.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  // create a state to switch between sign in form and register form
  // sign in form on true - register form on false
  bool toggleState = true;

  // create a function to toggle between the forms
  void toggleForms() {
    // set the state of toggleState
    setState(() {
      // !toggleState allows the value to be toggled, sets true to false and vice versa
      toggleState = !toggleState;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggleState) {
      // pass down toggle method as parameter to widget
      return SignIn(toggleForms: toggleForms);
    } else {
      // pass down toggle method as parameter to widget
      return Register(toggleForms: toggleForms);
    }
  }
}
