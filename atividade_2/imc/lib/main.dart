import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ImcCalculator(),
    );
  }
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = '';
  double _imc = 0.0;
  String _dieta = '';

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
      setState(() {
        _resultado = 'Por favor, insira valores válidos!';
        _imc = 0.0;
        _dieta = '';
      });
      return;
    }

    setState(() {
      _imc = peso / (altura * altura);
      _resultado = _obterMensagem(_imc);
      _dieta = '';
    });
  }

  String _obterMensagem(double imc) {
    if (imc < 18.5) {
      return 'falta só o caixão\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 18.5 && imc < 25) {
      return 'falta algo mais\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 25 && imc < 30) {
      return 'bolinha de gorf\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 30 && imc < 35) {
      return 'panda\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 35 && imc < 40) {
      return 'planeta\nIMC: ${imc.toStringAsFixed(1)}';
    } else {
      return 'tais carla\nIMC: ${imc.toStringAsFixed(1)}';
    }
  }

  Color _obterCor(double imc) {
    if (imc == 0.0) return Colors.grey;
    if (imc < 18.5) return Colors.blue;
    if (imc >= 18.5 && imc < 25) return Colors.green;
    if (imc >= 25 && imc < 30) return Colors.orange;
    return Colors.red;
  }

  String _obterImagemDieta(double imc) {
    if (imc < 18.5) return 'images/magro.png';
    if (imc >= 18.5 && imc < 25) return 'images/bomba..png';
    if (imc >= 25 && imc < 30) return 'images/sexo.png';
    return 'images/cadeado.png';
  }

  String _obterImagem(double imc) {
    if (imc < 18.5) return 'images/ganhomassa.png';
    if (imc >= 18.5 && imc < 25) return 'images/anabolisante.png';
    if (imc >= 25 && imc < 30) return 'images/leoncio.png';
    if (imc >= 30 && imc < 35) return 'images/panda.png';
    if (imc >= 35 && imc < 40) return 'images/gordo.png';
    return 'images/thais.png';
  }

  void _mostrarDieta() {
    setState(() {
      if (_imc < 18.5) {
        _dieta =
            'Dieta para ganho de peso:\n• Aumente calorias\n• Proteínas e carboidratos\n• Consulte um nutricionista\n• tome cuidado com o vento';
      } else if (_imc >= 18.5 && _imc < 25) {
        _dieta =
            'Dieta de manutenção:\n• Alimentação equilibrada\n• Frutas e vegetais\n• Hidratação adequada\n• começar a aplicar';
      } else if (_imc >= 25 && _imc < 30) {
        _dieta =
            'Dieta para perda de peso:\n• Reduza calorias\n• Mais vegetais\n• Exercícios regulares\n• fazer cardio\n• tem que meter mais';
      } else {
        _dieta =
            'Dieta restritiva:\n• Acompanhamento médico\n• Redução calórica\n• Atividade física supervisionada\n• cadialina, trancar a boca com cadeado e parar de comer';
      }
    });
  }

  void _limparTudo() {
    setState(() {
      _pesoController.clear();
      _alturaController.clear();
      _resultado = '';
      _imc = 0.0;
      _dieta = '';
    });
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(color: Color(0xFF315CFD), width: 3.0),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        return states.contains(MaterialState.hovered)
            ? const Color(0xFF315CFD)
            : Colors.white;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        return states.contains(MaterialState.hovered)
            ? Colors.white
            : const Color(0xFF315CFD);
      }),
      fixedSize: MaterialStateProperty.resolveWith<Size>((states) {
        return states.contains(MaterialState.hovered)
            ? const Size(160, 65)
            : const Size(150, 60);
      }),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
        return states.contains(MaterialState.hovered)
            ? const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)
            : const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(onPressed: _limparTudo, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/obesidade.png', width: 100, height: 100),
            const SizedBox(height: 16),
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularIMC,
              style: _buttonStyle(),
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _obterCor(_imc).withOpacity(0.1),
                border: Border.all(color: _obterCor(_imc)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  if (_imc > 0) ...[
                    Image.asset(_obterImagem(_imc), width: 175, height: 175),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    _resultado.isEmpty ? '' : _resultado,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _obterCor(_imc),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (_imc > 0) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _mostrarDieta,
                style: _buttonStyle(),
                child: const Text('Ver Dieta'),
              ),
            ],
            if (_dieta.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      _obterImagemDieta(_imc),
                      width: 175,
                      height: 175,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _dieta,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
