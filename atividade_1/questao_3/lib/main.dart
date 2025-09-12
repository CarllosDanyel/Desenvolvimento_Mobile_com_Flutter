import 'package:flutter/material.dart';

void main() {
  runApp(const LuhnApp());
}

class LuhnApp extends StatelessWidget {
  const LuhnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LuhnPage());
  }
}

class LuhnPage extends StatefulWidget {
  @override
  State<LuhnPage> createState() => _LuhnPageState();
}

class _LuhnPageState extends State<LuhnPage> {
  final TextEditingController _controller = TextEditingController();
  String result = "";

  bool luhnCheck(String number) {
    number = number.replaceAll(" ", "");
    if (number.length <= 1 || !RegExp(r'^\d+$').hasMatch(number)) return false;

    int sum = 0;
    bool doubleDigit = false;

    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);
      if (doubleDigit) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      doubleDigit = !doubleDigit;
    }

    return sum % 10 == 0;
  }

  void validate() {
    String input = _controller.text;
    bool isValid = luhnCheck(input);
    setState(() {
      result = isValid ? "Número válido ✅" : "Número inválido ❌";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luhn Validator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Digite o número"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: validate, child: const Text("Validar")),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
