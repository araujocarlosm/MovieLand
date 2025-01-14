import 'package:flutter/material.dart';
import 'package:movie_land/presentation/ui/widgets/movie_card.dart';
import 'package:movie_land/presentation/view_models/movies_view_model.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchMovies());
  }

  void fetchMovies() {
    context.read<MoviesViewModel>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The land.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF06223d),
        ),
        useMaterial3: false,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie Land'),
          elevation: 1,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => fetchMovies(),
                  child: Icon(Icons.refresh, size: 25),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Consumer<MoviesViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.isLoading) {
                return CircularProgressIndicator();
              }

              if (viewModel.errorMessage != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(viewModel.errorMessage!),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => viewModel.fetchMovies(),
                      child: Icon(Icons.refresh),
                    )
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: viewModel.movies.length,
                  itemBuilder: (context, index) {
                    final movie = viewModel.movies[index];
                    return MovieCard(movie: movie);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
