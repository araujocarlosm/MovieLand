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
}
