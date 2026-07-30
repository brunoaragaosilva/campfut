import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/campeonato_models.dart';
import 'campeonato_detalhes_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<Campeonato> campeonatos = [];
  final uuid = const Uuid();
  final TextEditingController _nomeController = TextEditingController();
  FormatoCampeonato _formatoSelecionado = FormatoCampeonato.pontosCorridos;

  @override
  void initState() {
    super.initState();
    _carregarCampeonatos();
  }

  Future<void> _carregarCampeonatos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cString = prefs.getString('campeonatos_list');
    if (cString != null) {
      final List decoded = jsonDecode(cString);
      setState(() {
        campeonatos = decoded.map((e) => Campeonato.fromMap(e)).toList();
      });
    }
  }

  Future<void> _salvarCampeonatos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('campeonatos_list', jsonEncode(campeonatos.map((e) => e.toMap()).toList()));
  }

  void _exibirCriarCampeonato() {
    _nomeController.clear();
    _formatoSelecionado = FormatoCampeonato.pontosCorridos;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Novo Campeonato", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome do Torneio", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<FormatoCampeonato>(
                value: _formatoSelecionado,
                decoration: const InputDecoration(labelText: "Formato de Disputa", border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: FormatoCampeonato.pontosCorridos, child: Text("Pontos Corridos")),
                  DropdownMenuItem(value: FormatoCampeonato.mataMata, child: Text("Apenas Mata-Mata")),
                  DropdownMenuItem(value: FormatoCampeonato.misto, child: Text("Pontos Corridos + Mata-Mata")),
                ],
                onChanged: (val) {
                  if (val != null) setDialogState(() => _formatoSelecionado = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar", style: TextStyle(color: Colors.grey))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
              onPressed: () {
                if (_nomeController.text.trim().isNotEmpty) {
                  setState(() {
                    campeonatos.add(Campeonato(
                      id: uuid.v4(),
                      nome: _nomeController.text.trim(),
                      formato: _formatoSelecionado,
                    ));
                  });
                  _salvarCampeonatos();
                  Navigator.pop(context);
                }
              },
              child: const Text("Criar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text("MEUS CAMPEONATOS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: campeonatos.isEmpty
          ? const Center(child: Text("Nenhum campeonato criado ainda.\nToque no '+' para começar!", textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontSize: 16)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: campeonatos.length,
              itemBuilder: (context, index) {
                final c = campeonatos[index];
                String formatoTexto = "Pontos Corridos";
                IconData formatoIcone = Icons.emoji_events;
                if (c.formato == FormatoCampeonato.mataMata) {
                  formatoTexto = "Mata-Mata Puro";
                  formatoIcone = Icons.account_tree;
                } else if (c.formato == FormatoCampeonato.misto) {
                  formatoTexto = "Grupos + Mata-Mata";
                  formatoIcone = Icons.flash_on;
                }

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: const Color(0xFFFEF3C7), child: Icon(formatoIcone, color: const Color(0xFFD97706))),
                    title: Text(c.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text(formatoTexto, style: const TextStyle(color: Colors.blueGrey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                            setState(() => campeonatos.removeAt(index));
                            _salvarCampeonatos();
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CampeonatoDetalhesView(campeonato: c)),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _exibirCriarCampeonato,
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

