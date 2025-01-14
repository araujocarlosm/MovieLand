import 'package:movie_land/data/models/movie_model.dart';
import 'package:movie_land/data/models/movies_response.dart';
import 'package:movie_land/domain/entities/movie.dart';

extension MoviesUtils on MoviesResponse {
  List<Movie> get toMovies => results.map((model) => model.toMovie).toList();
}

extension MovieModelUtils on MovieModel {
  Movie get toMovie => Movie.fromJson(toJson());
}

extension MovieUtils on Movie {
  String get poster =>
      'https://media.themoviedb.org/t/p/w220_and_h330_face/$posterPath';
}
