import 'package:flutter/material.dart';

class NovoCampeonatoView extends StatelessWidget {
  const NovoCampeonatoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Campeonato'),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: const Center(
        child: Text(
          'Tela de Criação de Campeonato',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0F172A),
    );
  }
}