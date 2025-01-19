import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../screens/joke_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke Types"),
        leading: IconButton(
          icon: const Icon(Icons.lightbulb),
          onPressed: () {
            Navigator.pushNamed(context, '/random-joke');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.pushNamed(context, '/random-joke');
            },
          ),
        ],
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorite-jokes');
            },
          ),
        ],

      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No joke types found."));
          }
          final jokeTypes = snapshot.data!;
          return ListView.builder(
            itemCount: jokeTypes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(jokeTypes[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JokeListScreen(type: jokeTypes[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
