import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
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
      ),
    );
  }
}

class TopList extends StatelessWidget {
  const TopList({super.key, required this.tops});

  final List<Top> tops;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemCount: tops.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(tops[index].hotWord),
            Text('${tops[index].hotWordNum}'),
          ],
        );
      },
    );
  }
}
