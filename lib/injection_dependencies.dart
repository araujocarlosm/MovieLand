import 'package:get_it/get_it.dart';
import 'package:movie_land/config/constants.dart';
import 'package:movie_land/core/networking/dio_client.dart';
import 'package:movie_land/data/data_sources/remote_data_source.dart';
import 'package:movie_land/data/repositories/movies_repository_impl.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';
import 'package:movie_land/domain/use_cases/get_movie_details_usecase.dart';
import 'package:movie_land/domain/use_cases/get_movies_usecase.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  locator.registerSingleton<DioClient>(DioClient(apiKey: apiKey));

  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(locator<DioClient>()));

  locator.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(locator<RemoteDataSource>()));

  locator.registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCase(locator<MoviesRepository>()));

  locator.registerLazySingleton<GetMovieDetailsUseCase>(
      () => GetMovieDetailsUseCase(locator<MoviesRepository>()));
}
