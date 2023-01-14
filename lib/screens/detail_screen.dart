import 'package:flutter/material.dart';
import 'package:nomadflutter/models/webtoon_model.dart';
import 'package:nomadflutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<DetailModel> detail;
  late Future<List<EpisodeModel>> episodes;
  bool isLike = false;
  late List<String>? likedWebtoon;

  @override
  void initState() {
    super.initState();
    detail = ApiService.getDetail(widget.id);
    episodes = ApiService.getEpisodes(widget.id);
    initPrefs();
  }

  Future initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    likedWebtoon = prefs.getStringList('likedToons');
    if (likedWebtoon != null) {
      if (likedWebtoon!
              .contains("${widget.title},${widget.thumb},${widget.id}") ==
          true) {
        setState(() {
          isLike = true;
        });
      }
    }
  }

  onFavoritePressed() async {
    final prefs = await SharedPreferences.getInstance();
    likedWebtoon = prefs.getStringList("likedToons");
    if (likedWebtoon != null) {
      if (isLike) {
        likedWebtoon!.remove("${widget.title},${widget.thumb},${widget.id}");
      } else {
        likedWebtoon!.add("${widget.title},${widget.thumb},${widget.id}");
      }
      await prefs.setStringList('likedToons', likedWebtoon!);
      setState(() {
        isLike = !isLike;
      });
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, likedWebtoon);
          },
        ),
        actions: [
          IconButton(
            onPressed: onFavoritePressed,
            icon: isLike
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
          )
        ],
        backgroundColor: Colors.green.shade600,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: Container(
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
                    child: Image.network(widget.thumb),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder(
              future: detail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.age),
                      Text(snapshot.data!.genre),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: episodes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Episodes(
                    snapshot: snapshot,
                    webtoonID: widget.id,
                  );
                } else {
                  return const Text("");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
