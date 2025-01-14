import 'package:flutter/widgets.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:movie_land/domain/use_cases/get_movie_details_usecase.dart';
import 'package:movie_land/injection_dependencies.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  final _getMovieDetailsUseCase = locator<GetMovieDetailsUseCase>();

  bool isLoading = false;
  MovieDetails? _movieDetails;

  void getMovieDetails(Movie movie) async {
    isLoading = true;
    notifyListeners();

    try {
      _movieDetails =
          await _getMovieDetailsUseCase.execute(params: movie.id.toString());
    } catch (e) {
      _movieDetails = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
