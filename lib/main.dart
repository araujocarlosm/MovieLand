import 'package:flutter/material.dart';

void main() {
  runApp(const MovieLand());
}

class MovieLand extends StatefulWidget {
  const MovieLand({super.key});

  @override
  State<MovieLand> createState() => _MovieLandState();
}

class _MovieLandState extends State<MovieLand> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The land.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF06223d)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Text("MovieLand!"),
        ),
      ),
    );
  }
}
