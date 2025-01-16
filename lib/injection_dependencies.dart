import 'package:get_it/get_it.dart';
import 'package:movie_land/config/constants.dart';
import 'package:movie_land/core/networking/dio_client.dart';
import 'package:movie_land/core/service/hive_local_storage_service.dart';
import 'package:movie_land/data/data_sources/local_data_source.dart';
import 'package:movie_land/data/data_sources/remote_data_source.dart';
import 'package:movie_land/data/repositories/movies_repository_impl.dart';
import 'package:movie_land/domain/repositories/movies_repository.dart';
import 'package:movie_land/domain/use_cases/get_local_movie_usecase.dart';
import 'package:movie_land/domain/use_cases/get_movie_details_usecase.dart';
import 'package:movie_land/domain/use_cases/get_movies_usecase.dart';
import 'package:movie_land/domain/use_cases/save_movie_usecase.dart';

final locator = GetIt.instance;

Future<void> initDependencies() async {
  locator.registerSingleton<DioClient>(
    DioClient(apiKey: apiKey),
  );

  locator.registerSingleton<HiveLocalStorageService>(
    HiveLocalStorageService(),
  );

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(locator<DioClient>()),
  );

  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(locator<HiveLocalStorageService>()),
  );

  locator.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      locator<RemoteDataSource>(),
      locator<LocalDataSource>(),
    ),
  );

  locator.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(locator<MoviesRepository>()),
  );

  locator.registerLazySingleton<GetMovieDetailsUseCase>(
    () => GetMovieDetailsUseCase(locator<MoviesRepository>()),
  );

  locator.registerLazySingleton<SaveMovieUseCase>(
    () => SaveMovieUseCase(locator<MoviesRepository>()),
  );

  locator.registerLazySingleton<GetLocalMovieUseCase>(
    () => GetLocalMovieUseCase(locator<MoviesRepository>()),
  );
}
