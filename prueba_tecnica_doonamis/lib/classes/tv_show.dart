import 'dart:convert';

class TVShow {
  int id;
  String name;
  String overview;
  double score;
  String imgPath;
  String releasedDate;
  double popularity;

  TVShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.score,
    required this.imgPath,
    required this.releasedDate,
    required this.popularity,
  });

  factory TVShow.fromMap(Map<String, dynamic> map) {
    return TVShow(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      overview: map['overview'] ?? '',
      score: (map['vote_average'] is int)
          ? map['vote_average'].toDouble()
          : (map['vote_average'] as double),
      imgPath: map['poster_path'] ?? '',
      releasedDate: map['first_air_date'],
      popularity: map['popularity'],
    );
  }

  factory TVShow.fromJson(String source) => TVShow.fromMap(json.decode(source));
}
