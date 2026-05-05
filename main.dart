import 'package:flutter/material.dart';
import 'dart:math';


void main() => runApp(const ReverseTabuApp());


class ReverseTabuApp extends StatelessWidget {
  const ReverseTabuApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reverse Tabu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const GameScreen(),
    );
  }
}

