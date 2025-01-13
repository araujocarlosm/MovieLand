import 'package:movie_land/core/networking/http_client.dart';
import 'package:movie_land/data/models/movie_query_params.dart';
import 'package:movie_land/data/models/movies_response.dart';
import 'package:movie_land/domain/entities/movie_details.dart';

abstract class RemoteDataSource {
  Future<MoviesResponse> fetchMovies(MovieQueryParams params);
  Future<MovieDetails> fetchMovieDetails(String movieId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final HttpClient client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<MovieDetails> fetchMovieDetails(String movieId) async {
    try {
      Map<String, dynamic> response = await client.get('/movie/$movieId');
      return MovieDetails.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }

  @override
  Future<MoviesResponse> fetchMovies(MovieQueryParams params) async {
    try {
      Map<String, dynamic> response = await client.get('/discover/movie');
      return MoviesResponse.fromJson(response);
    } catch (e) {
      throw Exception('Error parsing movies data.');
    }
  }
}
