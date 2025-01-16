import 'package:movie_land/core/usecase/use_case.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';

class GetLocalMovieUseCase implements UseCase<MovieDetails?, int> {
  final MoviesRepository _moviesRepository;

  GetLocalMovieUseCase(this._moviesRepository);

  @override
  Future<MovieDetails?> execute({int? params}) async {
    return await _moviesRepository.getSavedMovie(params ?? 0);
  }
}
