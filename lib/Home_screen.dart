import 'dart:convert';

import 'package:api/models/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Autogenerated> postlist = [];
  Future<List<Autogenerated>> getpostapi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var Data = jsonDecode(response.body.toString());
    postlist.clear();
    if (response.statusCode == 200) {
      for (var i in Data) {
        postlist.add(Autogenerated.fromJson(i));
      }
      return postlist;
    } else {
      throw Exception("Data cannot loadded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getpostapi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("No data");
              } else {
                return ListView.builder(
                    itemCount: postlist.length,
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('title' + postlist[index].title.toString()),
                              Text(postlist[index].body.toString())
                            ],
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
