import 'package:flutter/material.dart';
import 'package:flutter_project_2022/services/authenticate.dart';

class SignIn extends StatefulWidget {
  // ? needed after function for null-safe
  final Function? toggleForms;
  // create a Function to acccept toggleForms
  SignIn({this.toggleForms});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
        title: Text('Sign in to Music App'),
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              // refer to the widget to toggleForms - ! for null-safe
              widget.toggleForms!();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        // setup a child form for signing in and registering
        child: Form(
          // set key to global key _key
          key: _key,
          child: Column(
            children: <Widget>[
              // sized box to space out fields
              SizedBox(
                height: 20.0,
              ),
              // Email form field
              TextFormField(
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
                height: 20.0,
              ),
              // password form field
              TextFormField(
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
                height: 20.0,
              ),
              // create an elevated button to sign user in
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // check if form is valid based on current state - true / false - ! for null-safe
                  if (_key.currentState!.validate()) {
                    // dyanmic as we don't know if null or not - await and signInUser using email and password saved in state
                    dynamic userResult =
                        await _auth.signInUser(email, password);
                    // check if result is null
                    if (userResult == null) {
                      // this error is caught by firebase itself when it looks at the email - i.e. test is not valid so it won't work where as test@test.com is valid
                      // we also do not need an else statement as the stream we set up is always listening and knows when it is valid and automatically takes us through
                      // if userResult is null set state of error to error message
                      setState(() {
                        error = 'Could not sign in, check credentials!';
                      });
                    }
                  }
                },
              ),
              // sized box to space out fields
              SizedBox(height: 12.0),
              // text widget to display error message for invalid email from firebase
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
