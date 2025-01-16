abstract class BaseLocalStorageService<T> {
  Future<void> add(T value);
  Future<T?> get(int id);
  Future<List<T>?> getAll();
  Future<void> clear();
}