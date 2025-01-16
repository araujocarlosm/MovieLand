import 'package:movie_land/core/extensions/movies_extensions.dart';
import 'package:movie_land/data/data_sources/local_data_source.dart';
import 'package:movie_land/data/data_sources/remote_data_source.dart';
import 'package:movie_land/data/models/movie_query_params.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final RemoteDataSource _dataSource;
  final LocalDataSource _localDataSource;

  MoviesRepositoryImpl(
    this._dataSource,
    this._localDataSource,
  );

  @override
  Future<List<Movie>> fetchMovies() async {
    final moviesResponse = await _dataSource.fetchMovies(MovieQueryParams());
    return moviesResponse.toMovies;
  }

  @override
  Future<MovieDetails> getMovieDetails(String id) async {
    return await _dataSource.fetchMovieDetails(id);
  }

  @override
  Future<void> saveMovie(MovieDetails movieDetails) async {
    await _localDataSource.saveMovie(movieDetails);
  }

  @override
  Future<MovieDetails?> getSavedMovie(int id) async {
    return _localDataSource.getMovie(id);
  }
}
