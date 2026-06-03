import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

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

// MODEL
class TabuCard {
  final String term;
  final String definition;
  final List<String> keyWords;
  const TabuCard({required this.term, required this.definition, required this.keyWords});
}

// VERİTABANI (40 KART)
final List<TabuCard> allCards = [
  const TabuCard(
    term: 'Internet',
    definition: 'A global network of interconnected networks that allows billions of devices to communicate using shared protocols.',
    keyWords: ['network', 'global', 'connected', 'worldwide', 'web'],
  ),
  const TabuCard(
    term: 'Network of Networks',
    definition: 'The Internet is described this way because it connects thousands of individual networks — home, enterprise, ISP — into one global system.',
    keyWords: ['internet', 'connected', 'global', 'system', 'multiple'],
  ),
  const TabuCard(
    term: 'ISP',
    definition: 'An organization that provides users and organizations with access to the Internet (e.g. Türk Telekom, Vodafone).',
    keyWords: ['provider', 'access', 'internet', 'service', 'connection'],
  ),
  const TabuCard(
    term: 'Protocol',
    definition: 'A set of rules that define the format, order of messages exchanged, and actions taken between two or more communicating entities.',
    keyWords: ['rule', 'message', 'format', 'communication', 'standard'],
  ),
  const TabuCard(
    term: 'RFC',
    definition: 'Request for Comments — official documents published by the IETF that define Internet standards and protocols.',
    keyWords: ['document', 'standard', 'IETF', 'specification', 'comment'],
  ),
  const TabuCard(
    term: 'IETF',
    definition: 'Internet Engineering Task Force — the organization responsible for developing and promoting Internet standards.',
    keyWords: ['standard', 'organization', 'internet', 'RFC', 'engineering'],
  ),
  const TabuCard(
    term: 'Host',
    definition: 'Any end system connected to the Internet that runs application programs (e.g. smartphones, PCs, servers).',
    keyWords: ['device', 'end system', 'application', 'computer', 'connected'],
  ),
  const TabuCard(
    term: 'Client',
    definition: 'A host that initiates requests for services, such as a browser requesting a web page from a server.',
    keyWords: ['request', 'browser', 'user', 'service', 'host'],
  ),
  const TabuCard(
    term: 'Server',
    definition: 'A host that waits for and responds to incoming requests from clients, storing and serving content or services.',
    keyWords: ['respond', 'host', 'store', 'request', 'data'],
  ),
  const TabuCard(
    term: 'Data Center',
    definition: 'A facility housing thousands of servers that store content and run cloud applications for large-scale services.',
    keyWords: ['server', 'cloud', 'storage', 'facility', 'scale'],
  ),
  const TabuCard(
    term: 'Access Network',
    definition: 'The network that physically connects an end host to the first router (edge router) on a path toward the Internet.',
    keyWords: ['edge', 'router', 'connect', 'first', 'host'],
  ),
  const TabuCard(
    term: 'DSL',
    definition: 'Digital Subscriber Line — a type of access network that uses existing telephone lines to carry digital data.',
    keyWords: ['telephone', 'line', 'digital', 'access', 'home'],
  ),
  const TabuCard(
    term: 'DSLAM',
    definition: 'DSL Access Multiplexer — the device at the telephone company central office that separates voice and data signals from DSL lines.',
    keyWords: ['DSL', 'multiplexer', 'telephone', 'separate', 'central office'],
  ),
  const TabuCard(
    term: 'Cable Internet',
    definition: 'An access technology that uses coaxial cable television infrastructure to deliver broadband Internet to homes.',
    keyWords: ['coaxial', 'television', 'broadband', 'HFC', 'home'],
  ),
  const TabuCard(
    term: 'Wireless Network',
    definition: 'A network in which hosts connect to the access point via radio waves rather than physical cables (e.g. WiFi, 4G).',
    keyWords: ['WiFi', 'radio', 'cable-free', 'access point', 'mobile'],
  ),
  const TabuCard(
    term: 'Enterprise Network',
    definition: 'A local area network used in organizations such as companies or universities, typically mixing wired and wireless links.',
    keyWords: ['company', 'LAN', 'university', 'wired', 'organization'],
  ),
  const TabuCard(
    term: 'Home Network',
    definition: 'A small access network combining a cable or DSL modem, router, and WiFi to connect household devices to the Internet.',
    keyWords: ['router', 'WiFi', 'modem', 'household', 'DSL'],
  ),
  const TabuCard(
    term: 'Physical Media',
    definition: 'The actual material (wire, fiber, or radio spectrum) through which bits are transmitted from one device to another.',
    keyWords: ['wire', 'fiber', 'bit', 'transmit', 'medium'],
  ),
  const TabuCard(
    term: 'Guided Media',
    definition: 'Transmission media where the signal is confined to a physical path, such as twisted-pair copper wire or fiber-optic cable.',
    keyWords: ['copper', 'fiber', 'wire', 'physical', 'cable'],
  ),
  const TabuCard(
    term: 'Unguided Media',
    definition: 'Transmission media where signals propagate freely through the atmosphere, such as WiFi, satellite, or cellular radio.',
    keyWords: ['wireless', 'radio', 'atmosphere', 'satellite', 'signal'],
  ),
  const TabuCard(
    term: 'Packet',
    definition: 'A small unit of data formed by breaking a large message into chunks before transmission across a network.',
    keyWords: ['data', 'chunk', 'message', 'transmit', 'unit'],
  ),
  const TabuCard(
    term: 'Packet Length',
    definition: 'The size of a packet measured in bits; together with link bandwidth it determines transmission delay.',
    keyWords: ['size', 'bits', 'delay', 'bandwidth', 'transmission'],
  ),
  const TabuCard(
    term: 'Transmission Rate',
    definition: 'The speed at which a link pushes bits onto the wire, measured in bits per second (bps).',
    keyWords: ['speed', 'bps', 'link', 'bits', 'capacity'],
  ),
  const TabuCard(
    term: 'Bandwidth',
    definition: 'The maximum data-carrying capacity of a network link, typically measured in Mbps or Gbps.',
    keyWords: ['capacity', 'Mbps', 'link', 'speed', 'data'],
  ),
  const TabuCard(
    term: 'Network Core',
    definition: 'The mesh of high-speed routers and links that interconnects the edge networks and forwards packets across the Internet.',
    keyWords: ['router', 'mesh', 'forward', 'high-speed', 'backbone'],
  ),
  const TabuCard(
    term: 'Router',
    definition: 'A network device in the core that receives incoming packets and forwards them toward their destination.',
    keyWords: ['forward', 'packet', 'destination', 'device', 'core'],
  ),
  const TabuCard(
    term: 'Packet Switching',
    definition: 'A transmission technique where messages are divided into packets that travel independently through the network and are reassembled at the destination.',
    keyWords: ['divide', 'independent', 'reassemble', 'route', 'store-and-forward'],
  ),
  const TabuCard(
    term: 'Store and Forward',
    definition: 'The router must receive the entire packet before it begins transmitting it onto the next link.',
    keyWords: ['entire', 'receive', 'transmit', 'router', 'delay'],
  ),
  const TabuCard(
    term: 'Queueing',
    definition: 'When packets arrive at a router faster than they can be forwarded, they wait in an output buffer.',
    keyWords: ['buffer', 'wait', 'congestion', 'router', 'output'],
  ),
  const TabuCard(
    term: 'Buffer',
    definition: 'A temporary storage area in a router where packets wait before being transmitted on an output link.',
    keyWords: ['storage', 'queue', 'router', 'wait', 'output'],
  ),
  const TabuCard(
    term: 'Packet Loss',
    definition: 'When a router\'s buffer is full and an arriving packet is dropped because there is no space to store it.',
    keyWords: ['drop', 'full', 'buffer', 'congestion', 'discard'],
  ),
  const TabuCard(
    term: 'Circuit Switching',
    definition: 'A network method that reserves a dedicated end-to-end path for the entire duration of a communication session.',
    keyWords: ['dedicated', 'reserved', 'path', 'telephone', 'session'],
  ),
  const TabuCard(
    term: 'FDM',
    definition: 'Frequency Division Multiplexing — divides the frequency spectrum into bands so multiple circuits share a link simultaneously.',
    keyWords: ['frequency', 'spectrum', 'band', 'divide', 'circuit'],
  ),
  const TabuCard(
    term: 'TDM',
    definition: 'Time Division Multiplexing — divides time into frames and slots so each circuit uses the full bandwidth during its assigned slot.',
    keyWords: ['time', 'slot', 'frame', 'divide', 'circuit'],
  ),
  const TabuCard(
    term: 'Processing Delay',
    definition: 'The time a router takes to examine a packet\'s header and decide where to forward it.',
    keyWords: ['router', 'header', 'examine', 'decision', 'forward'],
  ),
  const TabuCard(
    term: 'Queueing Delay',
    definition: 'The time a packet waits in a router\'s queue before it can be transmitted on the output link.',
    keyWords: ['wait', 'queue', 'router', 'output', 'congestion'],
  ),
  const TabuCard(
    term: 'Transmission Delay',
    definition: 'The time to push all the bits of a packet onto the link, equal to packet length divided by transmission rate.',
    keyWords: ['bits', 'push', 'link', 'length', 'rate'],
  ),
  const TabuCard(
    term: 'Propagation Delay',
    definition: 'The time for a bit to travel from one end of a link to the other, depending on the physical medium and distance.',
    keyWords: ['travel', 'distance', 'medium', 'speed of light', 'link'],
  ),
  const TabuCard(
    term: 'Throughput',
    definition: 'The actual rate at which data is successfully delivered from sender to receiver, limited by the bottleneck link.',
    keyWords: ['rate', 'delivered', 'bottleneck', 'sender', 'receiver'],
  ),
  const TabuCard(
    term: 'VPN',
    definition: 'Virtual Private Network — creates an encrypted, private tunnel over the public Internet to securely connect remote users or networks.',
    keyWords: ['encrypted', 'tunnel', 'private', 'secure', 'remote'],
  ),
  const TabuCard(
    term: 'Firewall',
    definition: 'A security device that monitors and filters incoming and outgoing network traffic based on predefined rules to protect a network.',
    keyWords: ['security', 'filter', 'traffic', 'rule', 'protect'],
  ),
];

// TEMA RENKLERİ
const _aqua   = Color(0xFF7FD1E0);
const _lagoon = Color(0xFF2C8F9E);
const _coral  = Color(0xFFFF7E67);
const _dark   = Color(0xFF1E2A2B);

// OYUN EKRANI
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<TabuCard> _deck;
  int _index = 0;
  bool _revealed = false;
  bool _showingResult = false;
  bool _lastCorrect = false;
  int _score1 = 0;
  int _score2 = 0;
  int _team = 1;

  // SAYAÇ DEĞİŞKENLERİ
  static const int _timerDuration = 60;
  int _secondsLeft = _timerDuration;
  Timer? _timer;
  bool _timerRunning = false;

  // SÜRE BİTTİ DURUMU: SÜRE SIFIRA ULAŞINCA TRUE OLUR
  bool _timeUp = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetGame() {
    _timer?.cancel();
    _deck = List.from(allCards)..shuffle(Random());
    _index = 0;
    _revealed = false;
    _showingResult = false;
    _score1 = 0;
    _score2 = 0;
    _team = 1;
    _secondsLeft = _timerDuration;
    _timerRunning = false;
    _timeUp = false;
    setState(() {});
  }

  void _startTimer() {
    if (_timerRunning) return;
    _timerRunning = true;
    _timeUp = false;
    _secondsLeft = _timerDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        // SÜRE BİTTİ: SAYACI DURDUR VE _timeUp BAYRAĞINI AKTİF ET
        t.cancel();
        _timerRunning = false;
        setState(() => _timeUp = true);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  TabuCard get _card => _deck[_index];

  void _next({required bool correct}) {
    // SÜRE BİTMİŞSE KART GEÇİŞİNE İZİN VERME
    if (!_revealed) return;
    if (_timeUp) return;
    setState(() {
      _lastCorrect = correct;
      if (correct) {
        if (_team == 1) _score1++; else _score2++;
      }
      _showingResult = true;
    });
  }

  void _advance() {
    // SÜRE BİTMİŞSE SONRAKİ KARTA GEÇİŞE İZİN VERME
    if (_timeUp) return;
    setState(() {
      _index = (_index + 1) % _deck.length;
      _revealed = false;
      _showingResult = false;
    });
  }

  Color get _timerColor {
    if (_timeUp) return _coral;
    if (_secondsLeft > 20) return _lagoon;
    if (_secondsLeft > 10) return Colors.orange;
    return _coral;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _aqua,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // SKORLAR VE SAYAÇ SATIRI
              Row(children: [
                _ScoreCard(label: 'TEAM 1', score: _score1, active: _team == 1),
                const SizedBox(width: 8),
                // SAYAÇ WIDGET: TIKLAYINCA BAŞLAR, BİTİNCE TIME UP YAZAR
                GestureDetector(
                  onTap: (_timerRunning || _timeUp) ? null : _startTimer,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _timerColor, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _timeUp ? '00' : '${_secondsLeft.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: _timerColor,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          // DURUM METNİ: BAŞLAMAMIŞSA START, ÇALIŞIYORSA SEC, BİTMİŞSE TIME UP
                          _timeUp ? 'TIME UP' : (_timerRunning ? 'SEC' : 'START'),
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: _timerColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _ScoreCard(label: 'TEAM 2', score: _score2, active: _team == 2),
              ]),

              const SizedBox(height: 16),

              // SÜRE BİTİNCE OVERLAY KARTI GÖSTER, YOKSA NORMAL KART AKIŞI
              if (_timeUp)
                _TimeUpCard()
              else
                GestureDetector(
                  onTap: (!_revealed && !_showingResult)
                      ? () {
                          setState(() => _revealed = true);
                          if (!_timerRunning) _startTimer();
                        }
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

              const SizedBox(height: 16),

              // BUTONLAR: SÜRE BİTMİŞSE SADECE RESET GÖSTER
              if (_timeUp)
                SizedBox(
                  width: double.infinity,
                  child: _Btn(
                    label: 'YENİ TUR BAŞLAT ↺',
                    color: _lagoon,
                    // YENİ TUR: SAYACI SIFIRLA AMA SKORLARI KORU
                    onTap: () {
                      _timer?.cancel();
                      setState(() {
                        _deck = List.from(allCards)..shuffle(Random());
                        _index = 0;
                        _revealed = false;
                        _showingResult = false;
                        _secondsLeft = _timerDuration;
                        _timerRunning = false;
                        _timeUp = false;
                        // TAKIM DEĞİŞTİR: HANGİ TAKIM OYNADIYSA DİĞERİNE GEÇ
                        _team = _team == 1 ? 2 : 1;
                      });
                    },
                  ),
                )
              else if (_showingResult)
                SizedBox(
                  width: double.infinity,
                  child: _Btn(label: 'NEXT →', color: _lagoon, onTap: _advance),
                )
              else
                Row(children: [
                  Expanded(child: _Btn(
                    label: 'CORRECT ✓',
                    color: _lagoon,
                    onTap: _revealed ? () => _next(correct: true) : null,
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _Btn(
                    label: 'SKIP →',
                    color: _coral,
                    onTap: _revealed ? () => _next(correct: false) : null,
                  )),
                ]),

              const SizedBox(height: 10),

              // TAKİM DEĞİŞTİR VE TAM RESET BUTONLARI
              Row(children: [
                Expanded(child: _Btn(
                  label: 'SWITCH TEAM  (Team $_team)',
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

              const SizedBox(height: 8),

              // KART SAYACI
              Text(
                'Card ${_index + 1} / ${_deck.length}',
                style: TextStyle(fontSize: 11, color: _dark.withOpacity(0.55), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// SÜRE BİTTİ KARTI: OYUNU DURDURUR VE BİLGİ VERİR
class _TimeUpCard extends StatelessWidget {
  const _TimeUpCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.timer_off, size: 52, color: _coral),
          SizedBox(height: 14),
          Text('TIME UP!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,
                  color: _coral, letterSpacing: 3)),
          SizedBox(height: 8),
          Text('Süre doldu. Yeni tur başlatabilirsiniz.',
              style: TextStyle(fontSize: 13, color: _dark)),
        ],
      ),
    );
  }
}

// KARTI GİZLİ
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
          Text('PRESENTER',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,
                  color: _dark, letterSpacing: 3)),
          SizedBox(height: 8),
          Text('Tap to reveal and start describing',
              style: TextStyle(fontSize: 13, color: _lagoon)),
        ],
      ),
    );
  }
}

// KARTI AÇIK
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
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(card.term,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: _lagoon)),
            ),
            const SizedBox(height: 16),
            Container(height: 2, width: 48, color: _coral),
            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.key, size: 14, color: _coral),
                SizedBox(width: 4),
                Text('KEY WORDS',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
                        color: _coral, letterSpacing: 1.2)),
              ],
            ),
            const SizedBox(height: 12),

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

// SONUÇ KARTI
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: correct ? _lagoon : _coral,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                correct ? '✓ CORRECT!' : '✗ SKIPPED',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(card.term,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _lagoon)),
            ),
            const SizedBox(height: 12),
            Container(height: 2, width: 48, color: _coral),
            const SizedBox(height: 16),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 13, color: _lagoon),
                SizedBox(width: 4),
                Text('DEFINITION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
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

// KART KABUK
class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 420,
          maxHeight: 500,
        ),
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
      ),
    );
  }
}

// SKOR KARTI
class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final bool active;
  const _ScoreCard({required this.label, required this.score, required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? _lagoon.withOpacity(0.2) : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: active ? Border.all(color: _lagoon, width: 2) : null,
        ),
        child: Column(children: [
          Text(label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _dark)),
          const SizedBox(height: 2),
          Text('$score',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _lagoon)),
          if (active)
            Container(
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: _lagoon, borderRadius: BorderRadius.circular(10)),
              child: const Text('ACTIVE',
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
        ]),
      ),
    );
  }
}

// BUTON
class _Btn extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;
  final double? width;

  const _Btn({
    required this.label,
    required this.color,
    this.textColor = Colors.white,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: Material(
        color: onTap == null ? color.withOpacity(0.4) : color,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: textColor, fontSize: 14,
                    fontWeight: FontWeight.bold, letterSpacing: 0.8)),
          ),
        ),
      ),
    );
  }
}