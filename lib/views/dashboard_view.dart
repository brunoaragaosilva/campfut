import 'package:flutter/material.dart';
import '../models/campeonato_models.dart';
import 'campeonato_detalhes_view.dart';
import 'novo_campeonato.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<Campeonato> _campeonatos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Campeonatos'),
      ),
      body: _campeonatos.isEmpty
          ? const Center(child: Text('Nenhum campeonato cadastrado.'))
          : ListView.builder(
              itemCount: _campeonatos.length,
              itemBuilder: (context, index) {
                final camp = _campeonatos[index];
                return ListTile(
                  title: Text(camp.nome),
                  subtitle: Text('Modalidade: ${camp.modalidade.name} - Times: ${camp.times.length}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CampeonatoDetalhesView(campeonato: camp),
                      ),
                    ).then((_) => setState(() {}));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovoCampeonatoView(
                onCampeonatoCriado: (novoCamp) {
                  setState(() {
                    _campeonatos.add(novoCamp);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}