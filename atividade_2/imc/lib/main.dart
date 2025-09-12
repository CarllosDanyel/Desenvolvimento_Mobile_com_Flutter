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
        useMaterial3: true,
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

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

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
      _dieta = ''; // Limpa a dieta ao recalcular o IMC
    });
  }

  String _obterMensagem(double imc) {
    if (imc < 18.5) {
      return 'pau de catar manga\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 18.5 && imc < 25) {
      return 'falta so a seringa\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 25 && imc < 30) {
      return 'bolinha de gorf\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 30 && imc < 35) {
      return 'Kung fu panda\nIMC: ${imc.toStringAsFixed(1)}';
    } else if (imc >= 35 && imc < 40) {
      return 'planeta\nIMC: ${imc.toStringAsFixed(1)}';
    } else {
      return 'thais carla\nIMC: ${imc.toStringAsFixed(1)}';
    }
  }

  Color _obterCor(double imc) {
    if (imc == 0.0) return Colors.grey;
    if (imc < 18.5) return Colors.blue;
    if (imc >= 18.5 && imc < 25) return Colors.green;
    if (imc >= 25 && imc < 30) return Colors.orange;
    return Colors.red;
  }

  IconData _obterIcone(double imc) {
    if (imc == 0.0) return Icons.help_outline;
    if (imc < 18.5) return Icons.trending_up;
    if (imc >= 18.5 && imc < 25) return Icons.favorite;
    if (imc >= 25 && imc < 30) return Icons.warning;
    return Icons.error;
  }

  // --- NOVAS FUNÇÕES PARA OBTER CAMINHO DAS IMAGENS ---
  String _obterImagemImc(double imc) {
    if (imc == 0.0) return '../images/placeholder.png'; // Imagem padrão
    if (imc < 18.5) return '../images/magro.png';
    if (imc >= 18.5 && imc < 25) return './images/anabolisante.png';
    if (imc >= 25 && imc < 30) return './images/bolinha.png';
    if (imc >= 30 && imc < 35) return './images/planeta.png';
    if (imc >= 35 && imc < 40) return './images/obesidade2.png';
    return './images/obesidade3.png'; // Para IMC >= 40
  }

  String _obterImagemDieta(double imc) {
    if (imc < 18.5) {
      return './images/ganhomassa.png';
    } else if (imc >= 18.5 && imc < 25) {
      return './images/bomba..png';
    } else if (imc >= 25 && imc < 30) {
      return './assets/images/sexo.png';
    } else {
      return './assets/images/cadeado.png'; // Para IMC >= 30
    }
  }
  // --- FIM DAS NOVAS FUNÇÕES ---

  void _mostrarDieta() {
    setState(() {
      if (_imc < 18.5) {
        _dieta = 'Dieta para ganho de peso:\n• Aumente calorias\n• Proteínas e carboidratos\n• Consulte um nutricionista\n• cuidado com o vento';
      } else if (_imc >= 18.5 && _imc < 25) {
        _dieta = 'Dieta de manutenção:\n• Alimentação equilibrada\n• Frutas e vegetais\n• Hidratação adequada\n• comecar a aplicar';
      } else if (_imc >= 25 && _imc < 30) {
        _dieta = 'Dieta para perda de peso:\n• Reduza calorias\n• Mais vegetais\n• Exercícios regulares\n• tem que mete mais';
      } else {
        _dieta = 'Dieta restritiva:\n• Acompanhamento médico\n• Redução calórica\n• Atividade física supervisionada\n• cadialina trancar a boca para parar de comer';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _limparTudo,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- IMAGEM APÓS O CABEÇALHO ---
            Center(
              child: Image.asset(
                'assets/images/header_image.png', // Substitua pelo caminho da sua imagem
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            // --- FIM IMAGEM APÓS O CABEÇALHO ---

            const Icon(
              Icons.monitor_weight,
              size: 60,
              color: Colors.blue,
            ),
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
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
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
                    Icon(
                      _obterIcone(_imc),
                      size: 40,
                      color: _obterCor(_imc),
                    ),
                    const SizedBox(height: 8),
                    // --- IMAGEM POR CATEGORIA DE IMC ---
                    Image.asset(
                      _obterImagemImc(_imc),
                      width: 100, // Ajuste o tamanho conforme necessário
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    _resultado.isEmpty ? 'Resultado' : _resultado,
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
            if (_imc > 0)
              ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _mostrarDieta,
                  child: const Text('Ver Dieta'),
                ),
              ],
            if (_dieta.isNotEmpty)
              ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column( // Adicionado Column para a imagem da dieta
                    children: [
                      // --- IMAGEM POR TIPO DE DIETA ---
                      Image.asset(
                        _obterImagemDieta(_imc),
                        width: 100, // Ajuste o tamanho conforme necessário
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
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