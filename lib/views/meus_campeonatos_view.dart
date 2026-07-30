import 'package:flutter/material.dart';
import 'novo_campeonato.dart';

class MeusCampeonatosView extends StatefulWidget {
  const MeusCampeonatosView({Key? key}) : super(key: key);

  @override
  State<MeusCampeonatosView> createState() => _MeusCampeonatosViewState();
}

class _MeusCampeonatosViewState extends State<MeusCampeonatosView> {
  List<Map<String, dynamic>> campeonatos = [];

  void _abrirModalNovoCampeonato() {
    NovoCampeonatoModal.exibir(context, (novo) {
      setState(() {
        campeonatos.add(novo);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C853),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Meus campeonatos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _abrirModalNovoCampeonato,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Novo campeonato',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: campeonatos.isEmpty
                ? Center(
              child: Text(
                'Nenhum campeonato criado ainda.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: campeonatos.length,
              itemBuilder: (context, index) {
                final item = campeonatos[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C853).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        color: Color(0xFF00C853),
                      ),
                    ),
                    title: Text(
                      item['nome'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['descricao'] ?? item['modalidade'] ?? '',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.copy,
                          color: Colors.white54,
                          size: 18,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item['seguidores'] ?? 1} seguidores',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}