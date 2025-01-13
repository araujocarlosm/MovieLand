class Movie {
  int id;
  String title;
  String overview;
  String posterPath;
  String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
      );
}
