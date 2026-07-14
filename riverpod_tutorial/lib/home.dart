import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/joke.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke Generator')),
      body: SizedBox.expand(
        child: Consumer(
          builder: (context, ref, child) {
            final randomJoke = ref.watch(randomJokeProvider);

            return Stack(
              alignment: Alignment.center,
              children: [
                switch (randomJoke) {
                  // When the request completes successfully, we display the joke.
                  AsyncValue(:final value?) => SelectableText(
                    '${value.setup}\n\n${value.punchline}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                  // On error, we display a simple error message.
                  AsyncValue(error: != null) => const Text(
                    'Error fetching joke',
                  ),
                  // While the request is loading, we display a progress indicator.
                  AsyncValue() => const CircularProgressIndicator(),
                },

				if (randomJoke.isRefreshing) 
                	const Positioned(
						top: 0,
						left: 0,
						right: 0,
						child: LinearProgressIndicator()
					),

				Positioned(
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: () => ref.invalidate(randomJokeProvider),
                    child: const Text('Get another joke'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
