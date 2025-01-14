import 'package:flutter/material.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/presentation/ui/widgets/movie_details_content.dart';
import 'package:movie_land/presentation/view_models/movie_details_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: MovieDetailsContent(movie: widget.movie),
      ),
    );
  }
}
