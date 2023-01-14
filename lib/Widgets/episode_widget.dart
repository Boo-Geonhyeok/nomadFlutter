import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_model.dart';

class Episodes extends StatelessWidget {
  final AsyncSnapshot<List<EpisodeModel>> snapshot;
  final String webtoonID;

  const Episodes({super.key, required this.snapshot, required this.webtoonID});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var e = snapshot.data![index];
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await launchUrlString(
                      "https://comic.naver.com/webtoon/detail?titleId=$webtoonID&no=${snapshot.data![index].id}");
                },
                child: Image.network(
                  e.thumb,
                  width: 150,
                ),
              ),
              Text(e.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rate,
                  ),
                  Text(e.rating),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: snapshot.data!.length,
      ),
    );
  }
}
