import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weibo_top/detail.dart';
import 'package:weibo_top/models/photo.dart';
import 'package:weibo_top/models/response.dart';
import 'package:weibo_top/models/top.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = '微博热搜';

    return MaterialApp(
      title: title,
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        Detail.routeName: (context) => const Detail(),
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('微博热搜'),
      ),
      body: FutureBuilder<List<Top>>(
        future: fetchTopsFromLocal(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return TopList(tops: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class TopList extends StatelessWidget {
  const TopList({super.key, required this.tops});

  final List<Top> tops;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tops.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            child: ListTile(
              title: Text(tops[index].hotWord),
              subtitle: Text('${tops[index].hotWordNum}'),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              Detail.routeName,
              arguments:
                  DetailScreenArguments(tops[index].hotWord, tops[index].url),
            );
          },
        );
      },
    );
  }
}
