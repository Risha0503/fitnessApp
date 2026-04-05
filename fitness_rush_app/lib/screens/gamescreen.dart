import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> { // State variable to keep track of the jump count
  int jumpCount = 0;

  void increaseJumpCount() {
    setState(() { // Update the state to reflect the new jump count
      jumpCount++;
    });
  }

  @override // Build the UI for the game screen
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Rush'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          children: [
            Text(
              'Jumps: $jumpCount', // Display the current jump count
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Add some spacing between the text and the button
            ElevatedButton( // Button to simulate a jump and increase the jump count
              onPressed: increaseJumpCount,
              child: const Text('Test Jump'),
            ),
          ],
        ),
      ),
    );
  }
}