//import 'dart:html';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 10;
    final double itemWidth = size.width / 2;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      shrinkWrap: true,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          child: Align(
            alignment: Alignment.center,
            child: const Text(
              'Liked Songs',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.grey[800],
          height: 10,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          color: Colors.grey[800],
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          color: Colors.grey[800],
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          color: Colors.grey[800],
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          color: Colors.grey[800],
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          color: Colors.grey[800],
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
      ],
    );
  }
}
