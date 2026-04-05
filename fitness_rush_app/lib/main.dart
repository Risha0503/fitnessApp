import 'package:flutter/material.dart';
import 'package:fitness_rush_app/screens/gamescreen.dart';

void main(){
  runApp(const fitnessRushApp());
}
class fitnessRushApp extends StatelessWidget {
  const fitnessRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Rush',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const GameScreen(),
    );
  }
}