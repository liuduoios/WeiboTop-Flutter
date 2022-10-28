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
        future: fetchTops(),
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
          child: RowCard(
            index: index,
            top: tops[index],
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

class RowCard extends StatelessWidget {
  const RowCard({super.key, required this.index, required this.top});

  final int index;
  final Top top;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            width: 40,
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: colorOfIndex(index + 1),
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeOfIndex(index + 1),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    top.hotWord,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${top.hotWordNum}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Color colorOfIndex(int index) {
    if (index == 1) {
      return Colors.red;
    } else if (index == 2) {
      return Colors.red[400]!;
    } else if (index == 3) {
      return Colors.yellow[800]!;
    } else {
      return Colors.yellow[600]!;
    }
  }

  double fontSizeOfIndex(int index) {
    if (index == 1) {
      return 20;
    } else if (index == 2) {
      return 18;
    } else if (index == 3) {
      return 16;
    } else {
      return 14;
    }
  }
}
