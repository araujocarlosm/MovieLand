import 'package:hive_flutter/adapters.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/domain/entities/movie_details.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(MovieDetailsAdapter());
}