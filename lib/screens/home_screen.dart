import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nomadflutter/models/webtoon_model.dart';
import 'package:nomadflutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/webtoon_widget.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool haveLike = false;

  Future initPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    setState(() {});
    return prefs.getStringList("likedToons");
    // if (likedToons != null) {
    //   haveLike = true;
    //   likedWebtoons = likedToons;
    // } else {
    //   await prefs.setStringList('likedToons', []);

    //   haveLike = false;
    //   likedWebtoons = [];
    // }
  }

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: const Text(
          "Today's Webtoon",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: webtoons,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Webtoon(
                    snapshot: snapshot,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const Text(
            "Liked Webtoons",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: initPref(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LikedWebtoonWidget(likedWebtoons: snapshot.data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class LikedWebtoonWidget extends StatelessWidget {
  const LikedWebtoonWidget({
    Key? key,
    required this.likedWebtoons,
  }) : super(key: key);

  final List<String>? likedWebtoons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: likedWebtoons!.length,
      itemBuilder: (context, index) {
        var w = likedWebtoons;
        var wInfo = w![index].split(",");
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: wInfo[0],
                  thumb: wInfo[1],
                  id: wInfo[2],
                ),
              )),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(10, 10),
                      color: Colors.green.shade600,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 250,
                child: Image.network(wInfo[1]),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
