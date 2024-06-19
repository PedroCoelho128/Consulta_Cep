import 'dart:convert'; // Importação necessária para usar jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cepController = TextEditingController();
  String _result = '';
  bool _isLoading = false;

  Future<void> _searchCEP() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/${_cepController.text}/json/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      _result = 'CEP: ${data['cep']}\n'
          'Logradouro: ${data['logradouro']}\n'
          'Complemento: ${data['complemento']}\n'
          'Bairro: ${data['bairro']}\n'
          'Localidade: ${data['localidade']}\n'
          'UF: ${data['uf']}';
    } else {
      _result = 'CEP não encontrado';
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cepController,
              decoration: const InputDecoration(
                labelText: 'CEP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchCEP,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                _result,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
