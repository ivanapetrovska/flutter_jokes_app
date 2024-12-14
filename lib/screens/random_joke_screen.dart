import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Joke"),
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final joke = snapshot.data;
          return joke == null
              ? const Center(child: Text("No joke found."))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(joke.setup, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign:TextAlign.center,),
                const SizedBox(height: 10),
                Text(joke.punchline, style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,),
              ],
            ),
          );
        },
      ),
    );
  }
}
