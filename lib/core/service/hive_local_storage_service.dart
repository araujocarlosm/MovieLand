import 'package:hive/hive.dart';
import 'package:movie_land/core/service/base_local_storage_service.dart';
import 'package:movie_land/domain/entities/movie_details.dart';
import 'package:collection/collection.dart';

class HiveLocalStorageService implements BaseLocalStorageService<MovieDetails> {
  final String _boxName = "MovieBox";

  Future<Box<MovieDetails>> get _box async =>
      await Hive.openBox<MovieDetails>(_boxName);

  @override
  Future<void> add(MovieDetails value) async {
    final box = await _box;
    await box.add(value);
  }

  @override
  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }

  @override
  Future<List<MovieDetails>?> getAll() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<MovieDetails?> get(int id) async {
    final box = await _box;
    return box.values.toList().firstWhereOrNull((movie) => movie.id == id);
  }
}
