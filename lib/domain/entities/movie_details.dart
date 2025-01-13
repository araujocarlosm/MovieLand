import 'package:movie_land/domain/entities/movie.dart';

class MovieDetails extends Movie {
  List<String> genres;

  MovieDetails(
    this.genres, {
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        (json['genres'] as List<dynamic>)
            .map((element) => element['name'] as String)
            .toList(),
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
      );
}
