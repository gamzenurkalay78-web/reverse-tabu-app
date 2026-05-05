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
// Tema renkleri
const _aqua   = Color(0xFF7FD1E0);
const _lagoon = Color(0xFF2C8F9E);
const _coral  = Color(0xFFFF7E67);
const _dark   = Color(0xFF1E2A2B);


// ============ OYUN EKRANI ============
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});


  @override
  State<GameScreen> createState() => _GameScreenState();
}


class _GameScreenState extends State<GameScreen> {
  late List<TabuCard> _deck;
  int _index = 0;
  bool _revealed = false;
  bool _showingResult = false; // definition ekranı
  bool _lastCorrect = false;
  int _score1 = 0;
  int _score2 = 0;
  int _team = 1;


  @override
  void initState() {
    super.initState();
    _resetGame();
  }


  void _resetGame() {
    _deck = List.from(allCards)..shuffle(Random());
    _index = 0;
    _revealed = false;
    _showingResult = false;
    _score1 = 0;
    _score2 = 0;
    _team = 1;
    setState(() {});
  }


  TabuCard get _card => _deck[_index];


  // İlk basış: skoru güncelle + definition göster
  void _next({required bool correct}) {
    if (!_revealed) return;
    setState(() {
      _lastCorrect = correct;
      if (correct) {
        if (_team == 1) _score1++; else _score2++;
      }
      _showingResult = true;
    });
  }


  // Definition ekranından sonra sonraki karta geç
  void _advance() {
    setState(() {
      _index = (_index + 1) % _deck.length;
      _revealed = false;
      _showingResult = false;
    });
  }



