import 'package:flutter/material.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/use_cases/get_movies_usecase.dart';
import 'package:movie_land/injection_dependencies.dart';

class MoviesViewModel extends ChangeNotifier {
  final _getMoviesUseCase = locator<GetMoviesUseCase>();

  bool isLoading = false;
  String? errorMessage;
  List<Movie> movies = [];

  void fetchMovies() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      movies = await _getMoviesUseCase.execute();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
