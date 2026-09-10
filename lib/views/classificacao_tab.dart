import 'package:flutter/material.dart';
import '../models/campeonato_models.dart';

class TimeClassificacao {
  final Time time;
  int pontos = 0;
  int jogos = 0;
  int vitorias = 0;
  int empates = 0;
  int derrotas = 0;
  int golsPro = 0;
  int golsContra = 0;

  int get saldoGols => golsPro - golsContra;

  TimeClassificacao({required this.time});
}

class ClassificacaoTab extends StatelessWidget {
  final Campeonato campeonato;

  const ClassificacaoTab({super.key, required this.campeonato});

  List<TimeClassificacao> _calcularTabela() {
    Map<String, TimeClassificacao> tabelaMap = {
      for (var t in campeonato.times) t.id: TimeClassificacao(time: t)
    };

    for (var p in campeonato.partidas) {
      if (p.finalizada && p.golsMandante != null && p.golsVisitante != null) {
        var mandante = tabelaMap[p.timeMandanteId];
        var visitante = tabelaMap[p.timeVisitanteId];

        if (mandante != null && visitante != null) {
          mandante.jogos++;
          visitante.jogos++;

          mandante.golsPro += p.golsMandante!;
          mandante.golsContra += p.golsVisitante!;
          visitante.golsPro += p.golsVisitante!;
          visitante.golsContra += p.golsMandante!;

          if (p.golsMandante! > p.golsVisitante!) {
            mandante.vitorias++;
            mandante.pontos += 3;
            visitante.derrotas++;
          } else if (p.golsMandante! < p.golsVisitante!) {
            visitante.vitorias++;
            visitante.pontos += 3;
            mandante.derrotas++;
          } else {
            mandante.empates++;
            mandante.pontos += 1;
            visitante.empates++;
            visitante.pontos += 1;
          }
        }
      }
    }

    List<TimeClassificacao> lista = tabelaMap.values.toList();
    lista.sort((a, b) {
      if (b.pontos != a.pontos) return b.pontos.compareTo(a.pontos);
      if (b.vitorias != a.vitorias) return b.vitorias.compareTo(a.vitorias);
      if (b.saldoGols != a.saldoGols) return b.saldoGols.compareTo(a.saldoGols);
      return b.golsPro.compareTo(a.golsPro);
    });

    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final tabela = _calcularTabela();

    if (tabela.isEmpty) {
      return const Center(
        child: Text('Cadastre os times e lance jogos para ver a classificação.'),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Pos')),
            DataColumn(label: Text('Clube')),
            DataColumn(label: Text('P', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('J')),
            DataColumn(label: Text('V')),
            DataColumn(label: Text('E')),
            DataColumn(label: Text('D')),
            DataColumn(label: Text('GP')),
            DataColumn(label: Text('GC')),
            DataColumn(label: Text('SG')),
          ],
          rows: List.generate(tabela.length, (index) {
            final item = tabela[index];
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}º')),
                DataCell(Text(item.time.nome, style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text('${item.pontos}', style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text('${item.jogos}')),
                DataCell(Text('${item.vitorias}')),
                DataCell(Text('${item.empates}')),
                DataCell(Text('${item.derrotas}')),
                DataCell(Text('${item.golsPro}')),
                DataCell(Text('${item.golsContra}')),
                DataCell(Text('${item.saldoGols}')),
              ],
            );
          }),
        ),
      ),
    );
  }
}