import 'package:flutter/material.dart';


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int jumpCount = 0;

  double runnerBottom = 140;
  bool isJumping = false;

  int coins = 250;
  String timer = '01:25';
  double distanceKm = 2.3;

  Future<void> performJump() async {
    if (isJumping) return;

    setState(() {
      isJumping = true;
      jumpCount++;
      runnerBottom = 240;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      runnerBottom = 140;
      isJumping = false;
    });
  }
// this is the main build method for the game screen. It constructs the UI, including the HUD, runner, and jump button. The HUD displays coins, timer, and distance, while the runner is represented by an emoji that moves up when jumping. The jump button triggers the performJump function to simulate a jump action.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Rush'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
         SizedBox.expand(
  child: Image.asset(
    'lib/assets/images/stage1.png',
    fit: BoxFit.cover,
  ),
),
// The Stack widget allows for layering of UI elements, enabling the HUD to be positioned on top of the game background and the runner to be positioned above the ground. Each Positioned widget within the Stack is used to place specific UI components at desired locations on the screen, creating an engaging and interactive game interface.
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),// Semi-transparent background
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 1.2),
              ),
          //this is the HUD (Heads-Up Display) section of the game screen. It is positioned at the top of the screen and displays important game information such as coins, timer, and distance. The HUD has a semi-transparent black background with a red border, and it uses a Row widget to layout the individual HUD items (coins, timer, distance) with appropriate spacing.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHudItem('🪙', '$coins'),
                  _buildHudItem('⏱', timer),
                  _buildHudItem('📍', '${distanceKm.toStringAsFixed(1)} km'),
                ],
              ),
            ),
          ),
// This Positioned widget displays the jump count on the screen. It is placed near the top left corner and shows the number of jumps performed by the player. The text is styled with a white color, larger font size, and bold weight to make it easily visible against the game background.
          Positioned(
            top: 90,
            left: 20,
            child: Text(
              'Jumps: $jumpCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
Positioned(
  bottom: runnerBottom,
  left: MediaQuery.of(context).size.width / 2 - 50,
  child: SizedBox(
    width: 400,
    height: 400,
    child: Image.asset(
      'lib/assets/images/runner1_back_side.png',
      fit: BoxFit.contain,
    ),
  ),
),

          Positioned(
            bottom: 40,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: performJump,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Test Jump'),
              ),
            ),
          ),
        ],
      ),
    );
  }
// This helper method builds individual HUD items for the coins, timer, and distance. Each item consists of an icon (emoji) and a corresponding value. The method returns a Row widget that arranges the icon and value horizontally with some spacing in between. The text is styled to be white, bold, and of a specific font size to ensure readability against the game background.
  Widget _buildHudItem(String icon, String value) {
    return Row(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}