import 'dart:convert';
import 'director.dart';
import 'genre.dart';
import 'platform.dart';

class TVShow {
  int id;
  String name;
  String overview;
  double score;
  String imgPath;
  String releasedDate;
  double popularity;
  List<Director> directors;
  List<Genre> genres;
  List<Platform> platforms;
  List<String> originCountry;

  TVShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.score,
    required this.imgPath,
    required this.releasedDate,
    required this.popularity,
    required this.directors,
    required this.genres,
    required this.platforms,
    required this.originCountry,
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
      directors: map['created_by'] != null
          ? List<Director>.from(
              map['created_by'].map((element) => Director.fromMap(element)))
          : [],
      genres: map['genres'] != null
          ? List<Genre>.from(
              map['genres'].map((element) => Genre.fromMap(element)))
          : [],
      platforms: map['networks'] != null
          ? List<Platform>.from(
              map['networks'].map((element) => Platform.fromMap(element)))
          : [],
      originCountry: map['origin_country'] != null
          ? List<String>.from(map['origin_country'])
          : [],
    );
  }

  factory TVShow.fromJson(String source) => TVShow.fromMap(json.decode(source));
}
