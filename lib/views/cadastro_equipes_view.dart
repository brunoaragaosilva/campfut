import 'package:flutter/material.dart';

class CadastroEquipesView extends StatefulWidget {
  const CadastroEquipesView({super.key});

  @override
  State<CadastroEquipesView> createState() => _CadastroEquipesViewState();
}

class _CadastroEquipesViewState extends State<CadastroEquipesView> {
  final List<String> _equipes = [];
  final TextEditingController _equipeController = TextEditingController();

  void _adicionarEquipe() {
    if (_equipeController.text.trim().isNotEmpty) {
      setState(() {
        _equipes.add(_equipeController.text.trim());
        _equipeController.clear();
      });
    }
  }

  void _removerEquipe(int index) {
    setState(() {
      _equipes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Cadastro de Equipes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A2F),
              Color(0xFF0F172A),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campo para digitar o nome da equipe
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _equipeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nome da Equipe',
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: const Color(0xFF1E293B),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _adicionarEquipe,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Título da lista
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Equipes Cadastradas:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Lista de equipes
              Expanded(
                child: _equipes.isEmpty
                    ? const Center(
                  child: Text(
                    'Nenhuma equipe cadastrada ainda.',
                    style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
                  ),
                )
                    : ListView.builder(
                  itemCount: _equipes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF10B981),
                          child: Icon(Icons.sports_soccer, color: Colors.white, size: 18),
                        ),
                        title: Text(
                          _equipes[index],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => _removerEquipe(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}