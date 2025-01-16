import 'package:flutter/material.dart';
import 'package:movie_land/core/extensions/movies_extensions.dart';
import 'package:movie_land/domain/entities/movie.dart';
import 'package:movie_land/presentation/view_models/movie_details_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailsContent extends StatefulWidget {
  final Movie movie;

  const MovieDetailsContent({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailsContent> createState() => _MovieDetailsContentState();
}

class _MovieDetailsContentState extends State<MovieDetailsContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getMovieDetails());
  }

  void getMovieDetails() {
    context.read<MovieDetailsViewModel>().validateMovieDetails(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailsViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.movie.poster,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Release Date: ${widget.movie.releaseDate}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Genres:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: viewModel.genres
                      .map(
                        (genre) => Chip(
                          label: Text(genre),
                          backgroundColor: Colors.blueGrey,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Overview:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.movie.overview,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
