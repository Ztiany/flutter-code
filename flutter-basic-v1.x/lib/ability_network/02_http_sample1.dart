import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

/*使用 http 插件拉取网络数据，但是 http package 功能较弱，很多常用功能都不支持。*/
Widget buildHttpSample1Widget() => HttpSample1();

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

  final responseJson = json.decode(response.body);

  return new Post.fromJson(responseJson);
}

class HttpSample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        title: new Text('Fetch Data Example'),
      ),

      body: new Center(

        child: new FutureBuilder<Post>(

          future: fetchPost(),

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Text(snapshot.data.title);
            } else
            if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return new CircularProgressIndicator();
          },
        ),

      ),
    );
  }
}
