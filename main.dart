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
class _HiddenCard extends StatelessWidget {
  const _HiddenCard({super.key});


  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person_outline, size: 52, color: _lagoon),
          SizedBox(height: 14),
          Text('SUNUCU',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,
                  color: _dark, letterSpacing: 3)),
          SizedBox(height: 8),
          Text('Dokun ve anlatmaya başla',
              style: TextStyle(fontSize: 13, color: _lagoon)),
        ],
      ),
    );
  }
}


// ============ KARTI AÇIK (terim + yasaklı kelimeler) ============
class _RevealedCard extends StatelessWidget {
  final TabuCard card;
  const _RevealedCard({required this.card, super.key});


  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Terim
            Text(card.term,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: _lagoon)),
            const SizedBox(height: 16),
            Container(height: 2, width: 48, color: _coral),
            const SizedBox(height: 20),


            // Yasaklı kelimeler etiketi
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.key, size: 14, color: _coral),
                SizedBox(width: 4),
                Text('ANAHTAR KELİMELER',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                        color: _coral, letterSpacing: 1.2)),
              ],
            ),
            const SizedBox(height: 12),


            // Kelimeler
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: card.keyWords.map((kw) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _coral.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _coral.withOpacity(0.5)),
                ),
                child: Text(kw,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600, color: _dark)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}


// ============ SONUÇ KARTI (definition gösterir) ============
class _ResultCard extends StatelessWidget {
  final TabuCard card;
  final bool correct;
  const _ResultCard({required this.card, required this.correct, super.key});


  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Sonuç rozeti
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: correct ? _lagoon : _coral,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                correct ? '✓ BİLDİN!' : '✗ GEÇTİN',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),
  
            // Terim
            Text(card.term,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _lagoon)),
            const SizedBox(height: 12),
            Container(height: 2, width: 48, color: _coral),
            const SizedBox(height: 16),


            // Definition
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 13, color: _lagoon),
                SizedBox(width: 4),
                Text('TANIM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                    color: _lagoon, letterSpacing: 1.2)),
              ],
            ),
            const SizedBox(height: 8),
            Text(card.definition,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: _dark, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
// ============ KART KABUK ============
class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _lagoon, width: 3),
        boxShadow: [BoxShadow(
          color: _lagoon.withOpacity(0.25),
          blurRadius: 16, offset: const Offset(0, 8),
        )],
      ),
      child: child,
    );
  }
}


// ============ SKOR KARTI ============
class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final bool active;
  const _ScoreCard({required this.label, required this.score, required this.active});
