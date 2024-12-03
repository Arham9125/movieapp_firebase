import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/fire_base.dart';
import 'package:movieapp/screens/mmodel.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/screens/view_thepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class HomePage extends StatelessWidget {
  final List<Movie> mlist = [];
  String baseUrl = "http://www.omdbapi.com/?apikey=76e2ba21&s=movie&page=10";

  Future<List<Movie>> getcall() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['Search'] != null) {
        for (var i in data['Search']) {
          mlist.add(Movie.fromJson(i));
        }
      }
    } else {
      throw Exception("Failed to load data");
    }

    return mlist;
  }

 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movieapp"), centerTitle: true),
      body: FutureBuilder(
        future: getcall(),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error ${snapshot.error.toString()}',
                style: TextStyle(fontSize: 10),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String imageUrl = '${snapshot.data![index].poster}';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ViewPage(movie_name: snapshot.data![index]);
                        }));
                      },
                      child: Text(
                        snapshot.data![index].title.toString(),
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    subtitle: Text(snapshot.data![index].year.toString()),
                    trailing: FloatingActionButton(
                      onPressed: () {
                        
                        addMovieToFirestore(snapshot.data![index].title.toString());
                      },
                      child: Icon(Icons.add),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ViewPage(movie_name: snapshot.data![index]);
                        }));
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Image.network(imageUrl, height: 150),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
