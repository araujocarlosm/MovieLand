import 'package:movie_land/core/usecase/use_case.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';

class GetMovieDetailsUseCase implements UseCase<MovieDetails, String> {
  final MoviesRepository _moviesRepository;

  GetMovieDetailsUseCase(this._moviesRepository);

  @override
  Future<MovieDetails> execute({String? params}) {
    return _moviesRepository.getMovieDetails(params ?? '');
  }
}
