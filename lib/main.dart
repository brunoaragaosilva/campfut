import 'package:flutter/material.dart';

class NovoCampeonatoModal {
  // Modal 1: Escolha entre Único ou Com Categorias
  static void exibir(BuildContext context, Function(Map<String, dynamic>) onCampeonatoCriado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opção 1: Campeonato Único
                InkWell(
                  onTap: () {
                    Navigator.pop(context); // Fecha o primeiro modal
                    exibirSelecaoModalidade(context, onCampeonatoCriado); // Abre seleção de modalidade
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        color: Color(0xFF00C853),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Campeonato único',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Campeonato de uma única modalidade com apenas 1 categoria',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: Colors.black12, height: 1),
                ),

                // Opção 2: Campeonato com Categorias
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.add_box_rounded,
                        color: Color(0xFF00C853),
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Campeonato com categorias',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Campeonato com mais de uma categoria. Ex: divisões por idade, masculino/feminino, diferentes esportes ou outras categorias',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal 2: Seleção da Modalidade
  static void exibirSelecaoModalidade(
      BuildContext context, Function(Map<String, dynamic>) onCampeonatoCriado) {

    final List<Map<String, dynamic>> modalidades = [
      {'nome': 'Futsal', 'icon': Icons.sports_soccer, 'color': Colors.indigo},
      {'nome': 'Futebol', 'icon': Icons.sports_soccer, 'color': Colors.green},
      {'nome': 'Futebol 7', 'icon': Icons.sports_soccer, 'color': Colors.green.shade700},
      {'nome': 'Handebol', 'icon': Icons.sports_handball, 'color': Colors.orange.shade800},
      {'nome': 'Basquetebol', 'icon': Icons.sports_basketball, 'color': Colors.deepOrange},
      {'nome': 'Vôlei', 'icon': Icons.sports_volleyball, 'color': Colors.blue},
      {'nome': 'Vôlei de Praia', 'icon': Icons.beach_access, 'color': Colors.blue.shade800},
      {'nome': 'Tênis de Mesa', 'icon': Icons.sports_tennis, 'color': Colors.purple},
      {'nome': 'Tênis', 'icon': Icons.sports_tennis, 'color': Colors.lightGreen},
      {'nome': 'Beach Tennis', 'icon': Icons.sports_tennis, 'color': Colors.teal},
      {'nome': 'Xadrez', 'icon': Icons.extension, 'color': Colors.blueGrey},
      {'nome': 'Atletismo', 'icon': Icons.directions_run, 'color': Colors.amber.shade800},
      {'nome': 'Esporte Genérico', 'icon': Icons.emoji_events, 'color': Colors.deepOrange.shade300},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Selecione a modalidade',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Divider(color: Colors.black12),
                Expanded(
                  child: ListView.separated(
                    itemCount: modalidades.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
                    itemBuilder: (context, index) {
                      final item = modalidades[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (item['color'] as Color).withOpacity(0.15),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          item['nome'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context); // Fecha a seleção de modalidade
                          exibirFormularioNovoCampeonato(
                            context,
                            item['nome'] as String,
                            onCampeonatoCriado,
                          ); // Abre o formulário da imagem
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal 3: Formulário Final (da imagem enviada)
  static void exibirFormularioNovoCampeonato(
      BuildContext context, String modalidade, Function(Map<String, dynamic>) onCampeonatoCriado) {

    final TextEditingController nomeController = TextEditingController();
    String faseSelecionada = 'Pontos corridos';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: const Color(0xFFF1F0F5), // Fundo suave da imagem
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Novo campeonato',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo: Nome do campeonato
                    TextField(
                      controller: nomeController,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Nome do campeonato',
                        labelStyle: const TextStyle(color: Color(0xFF3B82F6), fontSize: 14),
                        hintText: 'Título',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                        filled: true,
                        fillColor: const Color(0xFFE5E7EB),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Fases do campeonato
                    const Text(
                      'Fases do campeonato',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Opção 1: Pontos corridos
                    RadioListTile<String>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Pontos corridos',
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                      value: 'Pontos corridos',
                      groupValue: faseSelecionada,
                      activeColor: const Color(0xFF2563EB),
                      onChanged: (value) {
                        setState(() {
                          faseSelecionada = value!;
                        });
                      },
                    ),

                    // Opção 2: Pontos corridos + Eliminatórias
                    RadioListTile<String>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Pontos corridos + Eliminatórias',
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                      value: 'Pontos corridos + Eliminatórias',
                      groupValue: faseSelecionada,
                      activeColor: const Color(0xFF2563EB),
                      onChanged: (value) {
                        setState(() {
                          faseSelecionada = value!;
                        });
                      },
                    ),

                    // Opção 3: Eliminatórias
                    RadioListTile<String>(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Eliminatórias',
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                      value: 'Eliminatórias',
                      groupValue: faseSelecionada,
                      activeColor: const Color(0xFF2563EB),
                      onChanged: (value) {
                        setState(() {
                          faseSelecionada = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 4),

                    // Texto informativo
                    Text(
                      'Você ainda poderá criar e remover as fases depois.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Botão "Criar campeonato"
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (nomeController.text.trim().isEmpty) return;

                          final novoCampeonato = {
                            'nome': nomeController.text.trim(),
                            'descricao': '$modalidade • $faseSelecionada',
                            'modalidade': modalidade,
                            'fase': faseSelecionada,
                            'seguidores': 1,
                          };

                          Navigator.pop(context); // Fecha o modal
                          onCampeonatoCriado(novoCampeonato); // Notifica a criação
                        },
                        child: const Text(
                          'Criar campeonato',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}