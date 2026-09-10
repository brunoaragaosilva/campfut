import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/campeonato_models.dart';

class PartidasTab extends StatefulWidget {
  final Campeonato campeonato;
  final VoidCallback onDataChanged;

  const PartidasTab({
    super.key,
    required this.campeonato,
    required this.onDataChanged,
  });

  @override
  State<PartidasTab> createState() => _PartidasTabState();
}

class _PartidasTabState extends State<PartidasTab> {
  final Uuid _uuid = const Uuid();

  // BOTÃO 1: Gerar tabela automática (Round Robin)
  void _gerarTabelaAutomatica() {
    if (widget.campeonato.times.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastre pelo menos 2 equipes para gerar a tabela.')),
      );
      return;
    }

    List<Time> listTimes = List.from(widget.campeonato.times);
    if (listTimes.length % 2 != 0) {
      listTimes.add(Time(id: 'BYE', nome: 'FOLGA', fundacao: '', jogadores: []));
    }

    int n = listTimes.length;
    int rodadas = n - 1;
    List<Partida> novasPartidas = [];

    for (int r = 0; r < rodadas; r++) {
      for (int i = 0; i < n / 2; i++) {
        Time t1 = listTimes[i];
        Time t2 = listTimes[n - 1 - i];

        if (t1.id != 'BYE' && t2.id != 'BYE') {
          novasPartidas.add(Partida(
            id: _uuid.v4(),
            timeMandanteId: t1.id,
            timeVisitanteId: t2.id,
            rodada: r + 1,
            data: DateTime.now().add(Duration(days: r * 7)),
            local: 'Estádio Principal',
          ));
        }
      }
      // Rotaciona a lista
      Time ultimo = listTimes.removeLast();
      listTimes.insert(1, ultimo);
    }

    setState(() {
      widget.campeonato.partidas = novasPartidas;
    });
    widget.onDataChanged();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${novasPartidas.length} partidas geradas automaticamente!')),
    );
  }

  // BOTÃO 2: Criar jogo manualmente
  void _modalCriarJogoManual() {
    if (widget.campeonato.times.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('É necessário ter ao menos 2 times cadastrados.')),
      );
      return;
    }

    String mandanteId = widget.campeonato.times.first.id;
    String visitanteId = widget.campeonato.times[1].id;
    int rodada = 1;
    final localController = TextEditingController(text: 'Campo Central');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Text('Criar Jogo Manualmente'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: mandanteId,
                  decoration: const InputDecoration(labelText: 'Time Mandante'),
                  items: widget.campeonato.times.map((t) {
                    return DropdownMenuItem(value: t.id, child: Text(t.nome));
                  }).toList(),
                  onChanged: (v) => setModalState(() => mandanteId = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: visitanteId,
                  decoration: const InputDecoration(labelText: 'Time Visitante'),
                  items: widget.campeonato.times.map((t) {
                    return DropdownMenuItem(value: t.id, child: Text(t.nome));
                  }).toList(),
                  onChanged: (v) => setModalState(() => visitanteId = v!),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: rodada.toString(),
                  decoration: const InputDecoration(labelText: 'Rodada'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => rodada = int.tryParse(v) ?? 1,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: localController,
                  decoration: const InputDecoration(labelText: 'Local da Partida'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('CANCELAR'),
            ),
            ElevatedButton(
              onPressed: () {
                if (mandanteId == visitanteId) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selecione times diferentes.')),
                  );
                  return;
                }
                final p = Partida(
                  id: _uuid.v4(),
                  timeMandanteId: mandanteId,
                  timeVisitanteId: visitanteId,
                  rodada: rodada,
                  data: DateTime.now(),
                  local: localController.text,
                );
                setState(() {
                  widget.campeonato.partidas.add(p);
                });
                widget.onDataChanged();
                Navigator.pop(ctx);
              },
              child: const Text('SALVAR JOGO'),
            ),
          ],
        ),
      ),
    );
  }

  // BOTÃO 3: Simular Resultados e Súmula Aleatória (Testes e Validação)
  void _gerarTabelaESimularAleatorio() {
    if (widget.campeonato.times.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastre pelo menos 2 equipes para simular.')),
      );
      return;
    }

    _gerarTabelaAutomatica();

    final rand = Random();

    for (var p in widget.campeonato.partidas) {
      final tMandante = widget.campeonato.times.firstWhere((t) => t.id == p.timeMandanteId);
      final tVisitante = widget.campeonato.times.firstWhere((t) => t.id == p.timeVisitanteId);

      int gM = rand.nextInt(5);
      int gV = rand.nextInt(5);

      p.golsMandante = gM;
      p.golsVisitante = gV;
      p.finalizada = true;
      p.eventos.clear();

      // Gerar gols e autores
      for (int i = 0; i < gM; i++) {
        String autor = _obterNomeAtletaOuFallback(tMandante, i + 1, rand);
        p.eventos.add(EventoPartida(nomeJogador: autor, tipo: 'gol', timeId: tMandante.id));
      }
      for (int i = 0; i < gV; i++) {
        String autor = _obterNomeAtletaOuFallback(tVisitante, i + 1, rand);
        p.eventos.add(EventoPartida(nomeJogador: autor, tipo: 'gol', timeId: tVisitante.id));
      }

      // Gerar Cartões Amarelos aleatórios (0 a 3)
      int amarM = rand.nextInt(3);
      for (int i = 0; i < amarM; i++) {
        String nome = _obterNomeAtletaOuFallback(tMandante, i + 1, rand);
        p.eventos.add(EventoPartida(nomeJogador: nome, tipo: 'amarelo', timeId: tMandante.id));
      }
      int amarV = rand.nextInt(3);
      for (int i = 0; i < amarV; i++) {
        String nome = _obterNomeAtletaOuFallback(tVisitante, i + 1, rand);
        p.eventos.add(EventoPartida(nomeJogador: nome, tipo: 'amarelo', timeId: tVisitante.id));
      }

      // Gerar Cartão Vermelho eventual
      if (rand.nextBool() && rand.nextBool()) {
        String nome = _obterNomeAtletaOuFallback(tMandante, 1, rand);
        p.eventos.add(EventoPartida(nomeJogador: nome, tipo: 'vermelho', timeId: tMandante.id));
      }
    }

    setState(() {});
    widget.onDataChanged();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Simulação concluída com placares, gols e cartões!')),
    );
  }

  String _obterNomeAtletaOuFallback(Time time, int index, Random rand) {
    if (time.jogadores.isNotEmpty) {
      return time.jogadores[rand.nextInt(time.jogadores.length)].nome;
    }
    return 'Jogador $index';
  }

  // Editar Resultado Manual do Jogo
  void _editarResultadoPartida(Partida p) {
    final gMController = TextEditingController(text: p.golsMandante?.toString() ?? '0');
    final gVController = TextEditingController(text: p.golsVisitante?.toString() ?? '0');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Editar Placar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gMController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: _obterNomeTime(p.timeMandanteId),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('x', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: TextField(
                    controller: gVController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: _obterNomeTime(p.timeVisitanteId),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCELAR'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                p.golsMandante = int.tryParse(gMController.text) ?? 0;
                p.golsVisitante = int.tryParse(gVController.text) ?? 0;
                p.finalizada = true;
              });
              widget.onDataChanged();
              Navigator.pop(ctx);
            },
            child: const Text('SALVAR PLACAR'),
          ),
        ],
      ),
    );
  }

  String _obterNomeTime(String timeId) {
    return widget.campeonato.times
        .firstWhere((t) => t.id == timeId, orElse: () => Time(id: '', nome: 'Time Removido', fundacao: '', jogadores: []))
        .nome;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Painel com os 3 botões solicitados
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.autorenew),
                label: const Text('1. GERAR TABELA AUTOMÁTICA'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                onPressed: _gerarTabelaAutomatica,
              ),
              const SizedBox(height: 6),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_task),
                label: const Text('2. CRIAR TABELA MANUALMENTE'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                onPressed: _modalCriarJogoManual,
              ),
              const SizedBox(height: 6),
              ElevatedButton.icon(
                icon: const Icon(Icons.casino),
                label: const Text('3. SIMULAR RESULTADOS & SÚMULAS (TESTES)'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                onPressed: _gerarTabelaESimularAleatorio,
              ),
            ],
          ),
        ),

        // Lista de Partidas
        Expanded(
          child: widget.campeonato.partidas.isEmpty
              ? const Center(
                  child: Text('Nenhuma partida gerada ainda.\nUtilize um dos botões acima!'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: widget.campeonato.partidas.length,
                  itemBuilder: (context, index) {
                    final p = widget.campeonato.partidas[index];
                    final mandante = _obterNomeTime(p.timeMandanteId);
                    final visitante = _obterNomeTime(p.timeVisitanteId);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              'RODADA ${p.rodada} • ${p.local}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    mandante,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: p.finalizada ? Colors.blue.shade50 : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    p.finalizada
                                        ? '${p.golsMandante} x ${p.golsVisitante}'
                                        : 'VS',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    visitante,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            // Eventos de Gols e Cartões na Súmula
                            if (p.eventos.isNotEmpty) ...[
                              const Divider(height: 16),
                              Wrap(
                                spacing: 8,
                                children: p.eventos.map((ev) {
                                  IconData ic;
                                  Color col;
                                  if (ev.tipo == 'gol') {
                                    ic = Icons.sports_soccer;
                                    col = Colors.black;
                                  } else if (ev.tipo == 'amarelo') {
                                    ic = Icons.style;
                                    col = Colors.amber.shade700;
                                  } else {
                                    ic = Icons.style;
                                    col = Colors.red;
                                  }
                                  return Chip(
                                    avatar: Icon(ic, size: 14, color: col),
                                    label: Text('${ev.nomeJogador} (${_obterNomeTime(ev.timeId)})', style: const TextStyle(fontSize: 11)),
                                    padding: EdgeInsets.zero,
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                icon: const Icon(Icons.edit_note),
                                label: Text(p.finalizada ? 'ALTERAR PLACAR' : 'LANÇAR RESULTADO'),
                                onPressed: () => _editarResultadoPartida(p),
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
    );
  }
}