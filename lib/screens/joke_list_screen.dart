import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';

class JokeListScreen extends StatelessWidget {
  final String type;

  const JokeListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jokes: $type"),
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No jokes found."));
          }
          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(jokes[index].setup),
                subtitle: Text(jokes[index].punchline),
              );
            },
          );

        },
      ),
    );
  }

}
