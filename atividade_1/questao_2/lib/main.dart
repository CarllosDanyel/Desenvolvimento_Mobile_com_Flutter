import 'package:flutter/material.dart';

void main() {
  runApp(const ResistorApp());
}

class ResistorApp extends StatelessWidget {
  const ResistorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ResistorPage());
  }
}

class ResistorPage extends StatefulWidget {
  @override
  State<ResistorPage> createState() => _ResistorPageState();
}

class _ResistorPageState extends State<ResistorPage> {
  final TextEditingController _controller = TextEditingController();
  String result = "";

  final Map<String, int> colors = {
    "preto": 0,
    "marrom": 1,
    "vermelho": 2,
    "laranja": 3,
    "amarelo": 4,
    "verde": 5,
    "azul": 6,
    "violeta": 7,
    "cinza": 8,
    "branco": 9,
  };

  void decode(String input) {
    List<String> parts = input.toLowerCase().split(RegExp(r"\s+"));
    if (parts.length < 2) {
      setState(() => result = "Insira pelo menos 2 cores");
      return;
    }
    int? first = colors[parts[0]];
    int? second = colors[parts[1]];
    if (first == null || second == null) {
      setState(() => result = "Cor inválida");
      return;
    }
    setState(() => result = "${first}${second}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resistor Decoder")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Digite as cores (ex: marrom verde)",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => decode(_controller.text),
              child: const Text("Decodificar"),
            ),
            const SizedBox(height: 20),
            Text("Resultado: $result", style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
