import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int jumpCount = 0;

  void increaseJumpCount() { //this function is called when the user presses the "Test Jump" button. It increments the jump count and updates the UI to reflect the new count.
    setState(() {
      jumpCount++;
    });
  }

  @override
  Widget build(BuildContext context) {//this is the main screen of the game where the user can see their jump count and a button to simulate a jump. The design is simple with a black background and red accents to match the theme of the app. The jump count is displayed at the top left corner, and a button is positioned at the bottom center for easy access.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Rush'),
        backgroundColor: Colors.red,
      ),
      body: Stack( //Stack is used to layer the different UI elements on top of each other, allowing for a more dynamic and visually appealing layout.
        children: [
          Container(
            color: Colors.black,
          ),

          Positioned( //Positioned widget is used to place the jump count text at a specific location on the screen, in this case, the top left corner. It allows for precise control over the placement of the UI element.
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

          Positioned(
            bottom: 140,
            left: MediaQuery.of(context).size.width / 2 - 30, //MediaQuery is used to get the width of the screen and position the jump icon in the center. By subtracting half of the icon's width (30) from the total width, it ensures that the icon is perfectly centered on the screen.
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
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

          Positioned(
            bottom: 40, //This button is positioned at the bottom center of the screen, making it easily accessible for the user to simulate a jump. When pressed, it calls the increaseJumpCount function to update the jump count.
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: increaseJumpCount,
                child: const Text('Test Jump'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}