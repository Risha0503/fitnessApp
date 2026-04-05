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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Rush'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),

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

          Positioned(
            bottom: runnerBottom,
            left: MediaQuery.of(context).size.width / 2 - 30,
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
            bottom: 40,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: SizedBox(
              width: 120,
              child: ElevatedButton(
                onPressed: performJump,
                child: const Text('Test Jump'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}