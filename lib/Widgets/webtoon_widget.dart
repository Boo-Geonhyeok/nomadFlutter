import 'package:flutter/material.dart';
import 'package:nomadflutter/screens/detail_screen.dart';

import '../models/webtoon_model.dart';

class Webtoon extends StatelessWidget {
  final AsyncSnapshot<List<WebtoonModel>> snapshot;

  const Webtoon({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var w = snapshot.data![index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                          title: w.title, thumb: w.thumb, id: w.id),
                    )),
                child: Column(
                  children: [
                    Hero(
                      tag: w.id,
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
                        child: Image.network(w.thumb),
                      ),
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
          ),
        ),
      ],
    );
  }
}
