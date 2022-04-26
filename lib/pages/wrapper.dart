import 'package:flutter/material.dart';
import 'package:flutter_project_2022/main.dart';
import 'package:flutter_project_2022/models/userModel.dart';
import 'package:flutter_project_2022/pages/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create a user variable to access the user data from the provider
    // Provider.of<UserModel?> as that is the type of data we are looking for
    final user = Provider.of<UserModel?>(context);

    // return either home or authentication
    if (user == null) {
      return Authentication();
    } else {
      return BotNavBar();
    }
  }
}
