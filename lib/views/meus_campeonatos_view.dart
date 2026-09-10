import 'package:flutter/material.dart';
import '../models/campeonato_models.dart';
import 'campeonato_detalhes_view.dart';
import 'novo_campeonato.dart';

class MeusCampeonatosView extends StatefulWidget {
  const MeusCampeonatosView({super.key});

  @override
  State<MeusCampeonatosView> createState() => _MeusCampeonatosViewState();
}

class _MeusCampeonatosViewState extends State<MeusCampeonatosView> {
  final List<Campeonato> _campeonatos = [];

  void _adicionarCampeonato(Campeonato campeonato) {
    setState(() {
      _campeonatos.add(campeonato);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Campeonatos'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NovoCampeonatoView(
                onSalvar: _adicionarCampeonato,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Campeonato'),
      ),
      body: _campeonatos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum campeonato cadastrado.\nClique no botão abaixo para começar!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _campeonatos.length,
              itemBuilder: (context, index) {
                final camp = _campeonatos[index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.emoji_events),
                    ),
                    title: Text(camp.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${camp.formato} • ${camp.modelo.nomeExibicao}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CampeonatoDetalhesView(campeonato: camp),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}