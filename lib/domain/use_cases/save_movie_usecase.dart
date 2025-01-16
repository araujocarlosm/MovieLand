import 'package:movie_land/core/usecase/use_case.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';

class SaveMovieUseCase implements UseCase<void, MovieDetails> {
  final MoviesRepository _moviesRepository;

  SaveMovieUseCase(this._moviesRepository);

  @override
  Future<void> execute({MovieDetails? params}) async {
    _moviesRepository.saveMovie(params!);
  }
}
