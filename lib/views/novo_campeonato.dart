import 'package:flutter/material.dart';
import 'cadastro_campeonato_unico_view.dart';

class NovoCampeonatoModal {
  // Modal 1: Escolha entre Único ou Com Categorias
  static void exibir(BuildContext context, Function(Map<String, dynamic>) onCampeonatoCriado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Campeonato de uma única modalidade com apenas 1 categoria',
                              style: TextStyle(
                                fontSize: 14,
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Campeonato com mais de uma categoria. Ex: divisões por idade, masculino/feminino, diferentes esportes ou outras categorias',
                              style: TextStyle(
                                fontSize: 14,
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

  // Modal 2: Seleção da Modalidade (estilo CopaFácil)
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Selecione a modalidade',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemCount: modalidades.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = modalidades[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (item['color'] as Color).withOpacity(0.15),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                          ),
                        ),
                        title: Text(
                          item['nome'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadastroCampeonatoUnicoView(
                                modalidadeSelecionada: item['nome'] as String,
                              ),
                            ),
                          );
                          if (resultado != null) {
                            onCampeonatoCriado(resultado);
                          }
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
}