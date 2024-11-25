import 'package:flutter/material.dart';

void main() => runApp(const NorepiApp());

class NorepiApp extends StatelessWidget {
  const NorepiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo Norepi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NorepiCalculator(),
    );
  }
}

class NorepiCalculator extends StatefulWidget {
  const NorepiCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NorepiCalculatorState createState() => _NorepiCalculatorState();
}

class _NorepiCalculatorState extends State<NorepiCalculator> {
  final _volumeNorepiController = TextEditingController();
  final _pesoPacienteController = TextEditingController();
  final _volumeTotalController = TextEditingController();

  String _resultText = "";

  void _calculateDose() {
    // Leitura e conversão dos valores de entrada
    final double volumeNorepi =
        double.tryParse(_volumeNorepiController.text) ?? 0;
    final double pesoPaciente =
        double.tryParse(_pesoPacienteController.text) ?? 0;
    final double volumeTotal =
        double.tryParse(_volumeTotalController.text) ?? 0;

    if (volumeNorepi == 0 || pesoPaciente == 0 || volumeTotal == 0) {
      setState(() {
        _resultText = "Por favor, preencha todos os campos corretamente.";
      });
      return;
    }

    // Cálculo da dose inicial
    final double doseInicial =
        (0.1 * 60 * pesoPaciente) / ((volumeNorepi * 1000) / volumeTotal);
    double doseFinal = 0.1;
    double doseTabela = doseInicial;

    // Construção do resultado em string para exibir
    String result =
        "${doseFinal.toStringAsFixed(2)} mcg/kg/min -> ${doseInicial.toStringAsFixed(2)} ml/hora\n";
    for (int i = 1; i <= 9; i++) {
      doseFinal += 0.1;
      doseTabela += doseInicial;
      result +=
          "${doseFinal.toStringAsFixed(2)} mcg/kg/min -> ${doseTabela.toStringAsFixed(2)} ml/hora\n";
    }

    setState(() {
      _resultText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo de Norepi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Importante!\n" +
                      "1. O volume de norepi deve ser informado em ml.\n" +
                      "2. O peso do paciente deve ser informado em kg.\n" +
                      "3. O volume total de norepi + soro deve ser informado em ml.\n" +
                      "4. Os valores informados devem ser apenas números.\n" +
                      "5. Para casas decimais, utilize ponto (.)\n" +
                      "6. Caso queira calcular novamente, preencha os campos e clique em 'Calcular'.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withAlpha(150)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _volumeNorepiController,
                  decoration: const InputDecoration(
                    labelText: "Quantos ml de norepi foi usado? (ml)",
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: _pesoPacienteController,
                  decoration: const InputDecoration(
                    labelText: "Qual peso do paciente? (kg)",
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: _volumeTotalController,
                  decoration: const InputDecoration(
                    labelText: "Qual volume total da norepi + soro usado? (ml)",
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateDose,
                  child: const Text("Calcular"),
                ),
                const SizedBox(height: 20),
                Text(
                  _resultText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
