import 'package:movie_land/core/service/base_local_storage_service.dart';
import 'package:movie_land/domain/entities/movie_details.dart';

abstract class LocalDataSource {
  Future<void> saveMovie(MovieDetails movie);

  Future<List<MovieDetails>> getMovies();

  Future<MovieDetails?> getMovie(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  final BaseLocalStorageService localStorageService;

  LocalDataSourceImpl(this.localStorageService);

  @override
  Future<MovieDetails?> getMovie(int id) async {
    try {
      return await localStorageService.get(id);
    } catch (e) {
      throw Exception('Error fetching saved movie: $e');
    }
  }

  @override
  Future<List<MovieDetails>> getMovies() async {
    try {
      final results = await localStorageService.getAll() ?? [];
      if (results is List<MovieDetails>) {
        return results;
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching saved movies: $e');
    }
  }

  @override
  Future<void> saveMovie(MovieDetails movie) async {
    try {
      await localStorageService.add(movie);
    } catch (e) {
      throw Exception('Error saving movie: $e');
    }
  }
}
