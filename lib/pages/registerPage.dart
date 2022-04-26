import 'package:flutter/material.dart';
import 'package:flutter_project_2022/services/authenticate.dart';
import 'package:flutter_project_2022/pages/verifyEmail.dart';

class Register extends StatefulWidget {
  // ? needed after function for null-safe
  final Function? toggleForms;
  // create a Function to acccept toggleForms
  Register({this.toggleForms});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // create an instance of AuthenticateService
  final AuthenticateService _auth = AuthenticateService();
  // create a FormState key to identify form
  final _key = GlobalKey<FormState>();

  // create states to store email and password from text fields
  String email = '';
  String password = '';
  // create a error state for error messages from firebase
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // prevents background image from moving up when the keyboard opens
      resizeToAvoidBottomInset: false,
      // main body of page
      body: Container(
        // decoration for the body
        decoration: BoxDecoration(
          // add a background image
          image: DecorationImage(
            image: AssetImage(
                'assets/images/man-dancing.jpg'), // image from - https://www.freepik.com/free-photo/medium-shot-man-dancing-with-headphones_15365814.htm
            // cover the whole screen
            fit: BoxFit.cover,
            // add a filter to darken the image into the background
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        // add padding to the whole body
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        // setup a child form for signing in and registering
        child: Form(
          // set key to global key _key
          key: _key,
          child: Column(
            children: <Widget>[
              // sized box to space out fields
              SizedBox(
                height: 50.0,
              ),

              // Heading text field
              Text(
                'Register',
                textScaleFactor: 3.0,
              ),

              // sized box to space out fields
              SizedBox(
                height: 100.0,
              ),

              // Email form field
              TextFormField(
                // decoration of field
                decoration: InputDecoration(
                  // change the fill color to grey
                  fillColor: Colors.grey.withOpacity(0.5), filled: true,
                  // add padding to the content in the field
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  // set the input border to none to remove the line
                  border: InputBorder.none,
                  // add a prefixIcon
                  prefixIcon: Padding(
                      // add padding to line up with the text
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      // add the email icon in white
                      child: Icon(Icons.email, color: Colors.white, size: 25)),
                  // add hint text saying email to let the user know what to enter
                  hintText: 'Email',
                ),
                // valid form by checking if empty - if empty return string if not empty return null
                validator: (value) => value!.isEmpty ? 'Enter an Email' : null,
                // get value in field whenever it is changed
                onChanged: (value) {
                  // set the state of email = value of text field
                  setState(() {
                    email = value;
                  });
                },
              ),

              // sized box to space out fields
              SizedBox(
                height: 30.0,
              ),

              // password form field
              TextFormField(
                // decoration of field
                decoration: InputDecoration(
                  // change the fill color to grey
                  fillColor: Colors.grey.withOpacity(0.5), filled: true,
                  // add padding to the content in the field
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  // set the input border to none to remove the line
                  border: InputBorder.none,
                  // add a prefixIcon
                  prefixIcon: Padding(
                      // add padding to line up with the text
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      // add the email icon in white
                      child: Icon(Icons.lock, color: Colors.white, size: 25)),
                  // add hint text saying Password to let the user know what to enter
                  hintText: 'Password',
                ),
                // valid form by checking if password is < 6 - if < 6 return string if 6+ chars return null
                validator: (value) =>
                    value!.length < 6 ? 'Enter a password 6+ chars long' : null,
                // obsure the text whenever entering a password
                obscureText: true,
                // get value in field whenever it is changed
                onChanged: (value) {
                  // set the state of password = value of text field
                  setState(() {
                    password = value;
                  });
                },
              ),

              // sized box to space out fields
              SizedBox(
                height: 100.0,
              ),

              // text widget to display error message for invalid email from firebase
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),

              // create an elevated button to register user to firebase
              Container(
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // check if form is valid based on current state - true / false - ! for null-safe
                      if (_key.currentState!.validate()) {
                        // dyanmic as we don't know if null or not - await and registerUser using email and password saved in state
                        dynamic userResult =
                            await _auth.registerUser(email, password).then((_) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => VerifyEmail()));
                        });
                        // check if result is null
                        if (userResult == null) {
                          // this error is caught by firebase itself when it looks at the email - i.e. test is not valid so it won't work where as test@test.com is valid
                          // we also do not need an else statement as the stream we set up is always listening and knows when it is valid and automatically takes us through
                          // if userResult is null set state of error to error message
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        }
                      }
                    }),
              ),

              // sized box to space out fields
              SizedBox(
                height: 30.0,
              ),

              // OR text field
              Text(
                'OR',
                textScaleFactor: 1.0,
              ),

              SizedBox(
                height: 20.0,
              ),

              // log in container
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    // refer to the widget to toggleForms - ! for null-safe
                    widget.toggleForms!();
                  },
                  child: const Text('Already have an account?'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
