import 'package:flutter/material.dart';

class MeusCampeonatosView extends StatelessWidget {
  const MeusCampeonatosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Campeonatos'),
      ),
      body: const Center(
        child: Text('Lista de Campeonatos'),
      ),
    );
  }
}