import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitness_rush_app/screens/challengescreen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int jumpCount = 0;

  double runnerBottom = 140;
  bool isJumping = false;

  int coins = 0;
  int seconds = 0;
  double distanceKm = 0.0;

  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
    startGameLoop();
  }
//this is where the game loop is implemented. It updates the time, distance, and checks for challenge triggers every second.
  bool challengeTriggered = false;
  void startGameLoop() {
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
        distanceKm += 0.05; // Simulate distance increase

// Trigger challenge at 1 minute  
        if (seconds == 60 && !challengeTriggered) {
          challengeTriggered = true;
          timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChallengeScreen()), //goes to the challenge screen when the time reaches 1 minute
          ).then((_) => startGameLoop());
        }
      });
    });
  }
// This getter formats the elapsed time in minutes and seconds for display on the HUD.
  String get formattedTime {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;

    final String minStr = minutes.toString().padLeft(2, '0');
    final String secStr = secs.toString().padLeft(2, '0');

    return '$minStr:$secStr'; // Returns time in MM:SS format
  }

  Future<void> performJump() async {
    if (isJumping) return;

    setState(() {
      isJumping = true;
      jumpCount++;
      runnerBottom = 240;
    });

    await Future.delayed(const Duration(milliseconds: 300)); // Simulate jump duration

    if (!mounted) return;

    setState(() {
      runnerBottom = 140;
      isJumping = false;
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }


 

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

          Container(
            color: Colors.black.withOpacity(0.25),
          ),

          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red, width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHudItem('🪙', '$coins'),
                  _buildHudItem('⏱', formattedTime),
                  _buildHudItem('📍', '${distanceKm.toStringAsFixed(1)} km'),
                ],
              ),
            ),
          ),

          
          Positioned(
            bottom: runnerBottom,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: SizedBox(
              width: 320,
              height: 320,
              child: Image.asset(
                'lib/assets/images/runner1_back_side.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
// This button allows the user to test the jump action, which simulates the runner jumping and updates the jump count.
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
}