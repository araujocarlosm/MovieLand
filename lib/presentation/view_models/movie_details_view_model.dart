import 'package:flutter/widgets.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/use_cases/get_local_movie_usecase.dart';
import 'package:movie_land/domain/use_cases/get_movie_details_usecase.dart';
import 'package:movie_land/domain/use_cases/save_movie_usecase.dart';
import 'package:movie_land/injection_dependencies.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final _getMovieDetailsUseCase = locator<GetMovieDetailsUseCase>();
  final _saveMovieUseCase = locator<SaveMovieUseCase>();
  final _getLocalMovieUseCase = locator<GetLocalMovieUseCase>();

  bool isLoading = false;
  MovieDetails? _movieDetails;

  void setDetails(MovieDetails details) {
    _movieDetails = details;
    notifyListeners();
  }

  void validateMovieDetails(Movie movie) async {
    final savedMovie = await _getLocalMovieUseCase.execute(params: movie.id);
    if (savedMovie != null) {
      setDetails(savedMovie);
    } else {
      getMovieDetails(movie);
    }
  }

  void getMovieDetails(Movie movie) async {
    isLoading = true;
    notifyListeners();

    try {
      final details =
          await _getMovieDetailsUseCase.execute(params: movie.id.toString());
      setDetails(details);
      saveMovie(details);
    } catch (e) {
      _movieDetails = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void saveMovie(MovieDetails movie) {
    _saveMovieUseCase.execute(params: movie);
  }

  List<String> get genres => _movieDetails?.genres ?? [];

  void clear() {
    _movieDetails = null;
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
