import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final List<Joke> favoriteJokes;

  const FavoriteJokesScreen({super.key, required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Jokes")),
      body: favoriteJokes.isEmpty
          ? const Center(child: Text("No favorite jokes yet."))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteJokes[index].setup),
            subtitle: Text(favoriteJokes[index].punchline),
          );
        },
      ),
    );
  }
}
