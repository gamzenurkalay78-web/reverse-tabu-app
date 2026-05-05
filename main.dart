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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _aqua,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // ── Skorlar ──
              Row(children: [
                _ScoreCard(label: 'TAKIM 1', score: _score1, active: _team == 1),
                const SizedBox(width: 12),
                _ScoreCard(label: 'TAKIM 2', score: _score2, active: _team == 2),
              ]),
  const SizedBox(height: 20),
   // ── Ana Kart ──
              Expanded(
                child: GestureDetector(
                  onTap: (!_revealed && !_showingResult)
                      ? () => setState(() => _revealed = true)
                      : null,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _showingResult
                        ? _ResultCard(card: _card, correct: _lastCorrect, key: ValueKey('result_$_index'))
                        : _revealed
                            ? _RevealedCard(card: _card, key: ValueKey(_index))
                            : _HiddenCard(key: const ValueKey('hidden')),
                  ),
                ),
              ),


              const SizedBox(height: 20),


              // ── BİLDİM / GEÇ veya DEVAM ──
              if (_showingResult)
                SizedBox(
                  width: double.infinity,
                  child: _Btn(label: 'DEVAM →', color: _lagoon, onTap: _advance),
                )
              else
                Row(children: [
                  Expanded(child: _Btn(
                    label: 'BİLDİM ✓',
                    color: _lagoon,
                    onTap: _revealed ? () => _next(correct: true) : null,
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _Btn(
                    label: 'GEÇ →',
                    color: _coral,
                    onTap: _revealed ? () => _next(correct: false) : null,
                  )),
                ]),


              const SizedBox(height: 12),


              // ── Takim Değiştir ──
              Row(children: [
                Expanded(child: _Btn(
                  label: 'TAKIM DEĞİŞTİR  (Takım $_team)',
                  color: Colors.white.withOpacity(0.5),
                  textColor: _dark,
                  onTap: () => setState(() => _team = _team == 1 ? 2 : 1),
                )),
                const SizedBox(width: 12),
                _Btn(
                  label: '↺',
                  color: Colors.white.withOpacity(0.5),
                  textColor: _dark,
                  onTap: _resetGame,
                  width: 52,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}


