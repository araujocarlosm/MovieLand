import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/entities/movie_details.dart';

abstract class MoviesRepository {
  Future<List<Movie>> fetchMovies();
  Future<MovieDetails> getMovieDetails(String id);
}