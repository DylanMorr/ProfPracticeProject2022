import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/main_pages/songsPage.dart';
import 'package:flutter_project_2022/pages/secondary_pages/rockHitsPage.dart';

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
          color: Colors.deepPurpleAccent,
          height: 10,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        GestureDetector(
          onTap: () { // navigate to Songs page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SongsPage()));},
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: const Text(
                'All Songs',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            color: Colors.deepPurpleAccent,
            height: 100,
            width: 100,
            margin: EdgeInsets.all(2),
          ),
        ),
        GestureDetector(
          onTap: () { // navigate to Songs page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RockPage()));},
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: const Text(
                'Rock Hits',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            color: Colors.deepPurpleAccent,
            height: 100,
            width: 100,
            margin: EdgeInsets.all(2),
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.center,
            child: const Text(
              'Dance Hits',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.deepPurpleAccent,
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          child: Align(
            alignment: Alignment.center,
            child: const Text(
              'Clubland Classics',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.deepPurpleAccent,
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
        Container(
          child: Align(
            alignment: Alignment.center,
            child: const Text(
              'Pop',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          color: Colors.deepPurpleAccent,
          height: 100,
          width: 100,
          margin: EdgeInsets.all(2),
        ),
      ],
    );
  }
}
