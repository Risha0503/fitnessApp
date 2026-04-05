import 'package:flutter/material.dart';
// This is the main game screen for the Fitness Rush app. It displays the runner character, jump counter, and a button to perform jumps.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}
// This is the state class for the GameScreen widget. It manages the state of the game, including the jump count, runner's position, and jump logic.
class _GameScreenState extends State<GameScreen> {
  int jumpCount = 0;

  double runnerBottom = 140; // this variable controls the vertical position of the runner character
  bool isJumping = false;// this variable tracks whether the runner is currently jumping to prevent multiple jumps at the same time
// This function is called when the jump button is pressed. It handles the jump logic, including updating the state to trigger a jump and resetting it after the jump duration.
  Future<void> performJump() async {
    if (isJumping) return;

    setState(() { //` this is where we update the state to trigger a jump
      isJumping = true;
      jumpCount++;
      runnerBottom = 240; // this moves the runner up to simulate a jump
    });

    await Future.delayed(const Duration(milliseconds: 300)); // this simulates the time the jump takes
// After the jump duration, we reset the runner's position and state
    setState(() {
      runnerBottom = 140; // this brings the runner back down after the jump
      isJumping = false; // reset the jumping state so we can jump again
    });
  }
// This is the main build method that constructs the UI of the game screen
  @override
  Widget build(BuildContext context) {
    return Scaffold( // this is the main structure of our game screen
      appBar: AppBar(
        title: const Text('Fitness Rush'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
// This is the jump counter displayed at the top left of the screen
          Positioned(
            top: 30,
            left: 20,
            child: Text(
              'Jumps: $jumpCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
// This is the runner character that will jump when the button is pressed
          Positioned(
            bottom: runnerBottom, // this is the runner's vertical position
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration( // this is the runner
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '🏃',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
          ),
// This is the jump button that the user will press to make the runner jump
          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width / 2 - 60, // this is the position of the jump button
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: performJump, // this is the function that gets called when the button is pressed
                child: const Text('Test Jump'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}