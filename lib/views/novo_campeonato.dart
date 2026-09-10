import 'package:flutter/material.dart';
import '../models/campeonato_models.dart';

class NovoCampeonatoView extends StatefulWidget {
  final Function(Campeonato) onCampeonatoCriado;

  const NovoCampeonatoView({Key? key, required this.onCampeonatoCriado}) : super(key: key);

  @override
  State<NovoCampeonatoView> createState() => _NovoCampeonatoViewState();
}

class _NovoCampeonatoViewState extends State<NovoCampeonatoView> {
  final _nomeController = TextEditingController();
  ModalidadeEsportiva _modalidadeSelecionada = ModalidadeEsportiva.futebol;
  ModeloCampeonato _modeloSelecionado = ModeloCampeonato.pontosCorridos;
  final List<Time> _times = [];
  final _timeController = TextEditingController();

  void _adicionarTime() {
    if (_timeController.text.trim().isEmpty) return;
    setState(() {
      _times.add(Time(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nome: _timeController.text.trim(),
      ));
      _timeController.clear();
    });
  }

  void _salvarCampeonato() {
    if (_nomeController.text.trim().isEmpty) return;
    final novoCamp = Campeonato(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      modalidade: _modalidadeSelecionada,
      modelo: _modeloSelecionado,
      times: _times,
    );
    widget.onCampeonatoCriado(novoCamp);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Campeonato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Campeonato'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ModalidadeEsportiva>(
              value: _modalidadeSelecionada,
              decoration: const InputDecoration(labelText: 'Modalidade'),
              items: ModalidadeEsportiva.values.map((mod) {
                return DropdownMenuItem(
                  value: mod,
                  child: Text(mod.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _modalidadeSelecionada = val);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ModeloCampeonato>(
              value: _modeloSelecionado,
              decoration: const InputDecoration(labelText: 'Modelo'),
              items: ModeloCampeonato.values.map((mod) {
                return DropdownMenuItem(
                  value: mod,
                  child: Text(mod.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _modeloSelecionado = val);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Nome do Time'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarTime,
                  child: const Text('Adicionar Time'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _times.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_times[index].nome),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _times.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: _salvarCampeonato,
              child: const Text('Salvar Campeonato'),
            ),
          ],
        ),
      ),
    );
  }
}