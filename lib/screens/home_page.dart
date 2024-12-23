import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/fire_base.dart';
import 'package:movieapp/screens/mmodel.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/screens/view_thepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> mlist = [];

  String baseUrl = "http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";

   TextEditingController _searchController = TextEditingController();
   List<Movie> postlist = [];
  List<Movie> filteredList = [];

   List<Movie> filteredMovies = [];

   void _filterMovies(String query) {
    setState(() {
      filteredMovies = mlist.where((movie) {
        return movie.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  Future<List<Movie>> getcall() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      
        for (var i in data) {
          mlist.add(Movie.fromJson(i));
        }
      
    } else {
      throw Exception("Failed to load data");
    }

    return mlist;
  }

    void findtheresult(String query) {
    List<Movie> tempList = [];

    if (query.isNotEmpty) {
      tempList = postlist.where((book) {
        return book.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      tempList = postlist;
    }
    setState(() {
      filteredList = tempList;
    });
  }

  TextEditingController result = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text("MAKEUP APP"), centerTitle: true),
      body: Column(
        
        children: [

                      Padding(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  onChanged: (value) {
                    findtheresult(value);
                  },
                  controller: result,
                  scrollPadding: EdgeInsets.all(10),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Search",
                    hintText: "Search the makeup",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      // Outline border color
                    ),
                  ),
                ),
              ),

          Expanded(
            child: FutureBuilder(
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
                      String imageUrl = '${snapshot.data![index].image_link}';
                  
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ViewPage(makeup: snapshot.data![index]);
                              }));
                            },
                            child: Text(
                              snapshot.data![index].name.toString(),
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          subtitle: Text(snapshot.data![index].price.toString()),
                          trailing: FloatingActionButton(
                            onPressed: () {
                              print("clicked");
                              addMovieToFirestore(snapshot.data![index].name.toString(), snapshot.data![index].price.toString());

                            },
                            child: Icon(Icons.add),
                          ),
                          leading: GestureDetector(
                            onTap: () {
                              print("clicked");
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ViewPage(makeup: snapshot.data![index]);
                              }));
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Image.network("${snapshot.data![index].image_link}", height: 150),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}