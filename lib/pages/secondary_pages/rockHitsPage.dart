import 'package:flutter/material.dart';
import 'package:flutter_project_2022/api/databaseManager.dart';
import 'package:flutter_project_2022/pages/secondary_pages/player.dart';

class RockPage extends StatefulWidget {
  const RockPage({Key? key}) : super(key: key);

  @override
  State<RockPage> createState() => _RockPageState();
}

class _RockPageState extends State<RockPage> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock Hits"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder(
        future: FireStoreDataBase().getRockHits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            print(dataList);
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(dataList) => ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          // return a card
          return Card(
            // create an inkwell
            child: InkWell(
              // when you pick a song navigate to the player and pass down the details
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Player(
                          title: dataList[index]["song_name"].toString(),
                          artist: dataList[index]["artist_name"].toString(),
                          url: dataList[index]["song_url"].toString(),
                          image: dataList[index]["image_url"].toString()))),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  dataList[index]["song_name"].toString() +
                      " - " +
                      dataList[index]["artist_name"].toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            elevation: 10.0,
          );
        },
      );
}
