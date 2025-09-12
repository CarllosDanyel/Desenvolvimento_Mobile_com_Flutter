import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _alcoolController = TextEditingController();
  TextEditingController _gasolinaController = TextEditingController();
  String _resultado = "";

  void _calcular() {
    double alcool = double.tryParse(_alcoolController.text) ?? 0;
    double gasolina = double.tryParse(_gasolinaController.text) ?? 0;

    if (gasolina >= alcool * 0.7) {
      _resultado = "Gasolina";
    } else {
      _resultado = "Álcool";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool vs Gasolina"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _alcoolController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Valor do Alcool",
              prefix: Text("R\$ "),
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          TextField(
            controller: _gasolinaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Valor da Gasolina",
              prefix: Text("R\$ "),
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          ElevatedButton(onPressed: _calcular, child: const Text("Calcular")),
          Text(
            _resultado,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
