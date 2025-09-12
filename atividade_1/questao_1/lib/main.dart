import 'package:flutter/material.dart';

void main() {
  runApp(const ScrabbleApp());
}

class ScrabbleApp extends StatelessWidget {
  const ScrabbleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScrabblePage());
  }
}

class ScrabblePage extends StatefulWidget {
  @override
  State<ScrabblePage> createState() => _ScrabblePageState();
}

class _ScrabblePageState extends State<ScrabblePage> {
  final TextEditingController _controller = TextEditingController();
  int score = 0;

  final Map<String, int> values = {
    "A": 1,
    "E": 1,
    "I": 1,
    "O": 1,
    "U": 1,
    "L": 1,
    "N": 1,
    "R": 1,
    "S": 1,
    "T": 1,
    "D": 2,
    "G": 2,
    "B": 3,
    "C": 3,
    "M": 3,
    "P": 3,
    "F": 4,
    "H": 4,
    "V": 4,
    "W": 4,
    "Y": 4,
    "K": 5,
    "J": 8,
    "X": 8,
    "Q": 10,
    "Z": 10,
  };

  void calculateScore(String word) {
    int total = 0;
    for (var c in word.toUpperCase().split('')) {
      total += values[c] ?? 0;
    }
    setState(() {
      score = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scrabble Score")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Digite a palavra"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => calculateScore(_controller.text),
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            Text(
              "Pontuação: $score pontos",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
