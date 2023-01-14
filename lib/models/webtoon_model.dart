class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}

class DetailModel {
  final String title, about, age, thumb, genre;

  DetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        about = json["about"],
        genre = json["genre"],
        age = json["age"],
        thumb = json["thumb"];
}

class EpisodeModel {
  final String thumb, id, title, rating, date;

  EpisodeModel.fromJson(Map<String, dynamic> json)
      : thumb = json["thumb"],
        id = json["id"],
        title = json["title"],
        rating = json["rating"],
        date = json["date"];
}
