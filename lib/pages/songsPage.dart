import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/databaseManager.dart';
import 'package:flutter_project_2022/pages/player.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Songs"),
      ),
      body: FutureBuilder(
        future: FireStoreDataBase().getData(),
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
                return Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Player(
                                title:dataList[index]["song_name"].toString(),
                                artist:dataList[index]["artist_name"].toString(),
                                url:dataList[index]["song_url"].toString(),
                                image:dataList[index]["image_url"].toString()))),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        dataList[index]["song_name"].toString() +" - "+ dataList[index]["artist_name"].toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        ),),),
                  elevation: 10.0,
                );},
            );
}


