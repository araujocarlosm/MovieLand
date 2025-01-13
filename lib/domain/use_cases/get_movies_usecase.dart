import 'package:movie_land/core/usecase/use_case.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';

class GetMoviesUseCase implements UseCase<List<Movie>, void> {
  final MoviesRepository _moviesRepository;

  GetMoviesUseCase(this._moviesRepository);

  @override
  Future<List<Movie>> execute(void params) {
    return _moviesRepository.fetchMovies();
  }
}
