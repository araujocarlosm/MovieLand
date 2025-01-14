import 'package:flutter/material.dart';
import 'package:movie_land/injection_dependencies.dart';
import 'package:movie_land/presentation/ui/screens/movies_screen.dart';
import 'package:movie_land/presentation/view_models/movies_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesViewModel()),
      ],
      child: const MoviesScreen(),
    ),
  );
}
