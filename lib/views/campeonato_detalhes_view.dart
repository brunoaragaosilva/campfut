import 'package:flutter/material.dart';
import '../models/campeonato_models.dart';
import 'partidas_tab.dart';
import 'classificacao_tab.dart';

class CampeonatoDetalhesView extends StatefulWidget {
  final Campeonato campeonato;

  const CampeonatoDetalhesView({super.key, required this.campeonato});

  @override
  State<CampeonatoDetalhesView> createState() => _CampeonatoDetalhesViewState();
}

class _CampeonatoDetalhesViewState extends State<CampeonatoDetalhesView> {
  void _atualizar() {
    setState(() {});
  }

  // Modal original para cadastrar equipe
  void _modalAdicionarTime() {
    final nomeController = TextEditingController();
    final fundacaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cadastrar Nova Equipe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome da Equipe',
                hintText: 'Ex: Flamengo',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: fundacaoController,
              decoration: const InputDecoration(
                labelText: 'Ano de Fundação / Bairro (Opcional)',
                hintText: 'Ex: 1895',
              ),
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
              if (nomeController.text.trim().isEmpty) return;
              final novoTime = Time(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                nome: nomeController.text.trim(),
                fundacao: fundacaoController.text.trim(),
                jogadores: [],
              );
              setState(() {
                widget.campeonato.times.add(novoTime);
              });
              Navigator.pop(ctx);
            },
            child: const Text('CADASTRAR'),
          ),
        ],
      ),
    );
  }

  // MODAL DE ATLETA COMPLETO E ATUALIZADO (Mantendo o layout do app e inserindo os novos campos)
  void _modalSalvarJogador(Time time, {Jogador? jogadorExistente}) {
    final isEdicao = jogadorExistente != null;
    final nomeController = TextEditingController(text: jogadorExistente?.nome ?? '');
    final apelidoController = TextEditingController(text: jogadorExistente?.apelido ?? '');
    final posicaoController = TextEditingController(text: jogadorExistente?.posicao ?? '');
    final numeroController = TextEditingController(
        text: jogadorExistente != null && jogadorExistente.numeroCamisa > 0
            ? jogadorExistente.numeroCamisa.toString()
            : '');
    final documentoController = TextEditingController(text: jogadorExistente?.documento ?? '');
    final dataNascimentoController = TextEditingController(text: jogadorExistente?.dataNascimento ?? '');
    final telefoneController = TextEditingController(text: jogadorExistente?.telefone ?? '');

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícone de Fechar (X)
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 22),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(height: 8),

                // Foto 200x240 + Nome + Apelido
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 85,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.black54, size: 20),
                          SizedBox(height: 2),
                          Text(
                            '200x240',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: nomeController,
                            decoration: const InputDecoration(
                              labelText: 'Nome do jogador',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: apelidoController,
                            decoration: const InputDecoration(
                              labelText: 'Apelido',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Posição
                TextField(
                  controller: posicaoController,
                  decoration: const InputDecoration(
                    labelText: 'Posição do jogador',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),

                // Nº da camisa/registro + Documento
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: numeroController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Nº da camisa/registro',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: documentoController,
                        decoration: const InputDecoration(
                          labelText: 'Documento',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Data de nascimento + Telefone
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dataNascimentoController,
                        decoration: const InputDecoration(
                          labelText: 'Data de nascimento',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: telefoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Estatísticas e Transferência
                const Divider(height: 1),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.show_chart, color: Colors.green, size: 20),
                  title: const Text('Estatísticas do campeonato',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  onTap: () {},
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.swap_horiz, color: Colors.teal, size: 20),
                  title: const Text('Transferir jogador',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  subtitle: Text('Desde: ${jogadorExistente?.dataEntrada ?? "09/09/2026"}',
                      style: const TextStyle(fontSize: 11)),
                  onTap: () {},
                ),
                const SizedBox(height: 12),

                // Botões do Rodapé (Remover e Salvar)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (isEdicao) {
                          setState(() {
                            time.jogadores.remove(jogadorExistente);
                          });
                        }
                        Navigator.pop(ctx);
                      },
                      child: const Text('Remover', style: TextStyle(color: Colors.red, fontSize: 15)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (nomeController.text.trim().isEmpty) return;

                        setState(() {
                          if (isEdicao) {
                            jogadorExistente.nome = nomeController.text.trim();
                            jogadorExistente.apelido = apelidoController.text.trim();
                            jogadorExistente.posicao = posicaoController.text.trim();
                            jogadorExistente.numeroCamisa = int.tryParse(numeroController.text) ?? 0;
                            jogadorExistente.documento = documentoController.text.trim();
                            jogadorExistente.dataNascimento = dataNascimentoController.text.trim();
                            jogadorExistente.telefone = telefoneController.text.trim();
                          } else {
                            time.jogadores.add(
                              Jogador(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                nome: nomeController.text.trim(),
                                apelido: apelidoController.text.trim(),
                                posicao: posicaoController.text.trim(),
                                numeroCamisa: int.tryParse(numeroController.text) ?? 0,
                                documento: documentoController.text.trim(),
                                dataNascimento: dataNascimentoController.text.trim(),
                                telefone: telefoneController.text.trim(),
                              ),
                            );
                          }
                        });
                        Navigator.pop(ctx);
                      },
                      child: const Text('Salvar',
                          style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Cálculo da Artilharia
  List<Map<String, dynamic>> _calcularArtilharia() {
    final Map<String, Map<String, dynamic>> artilheirosMap = {};

    for (var p in widget.campeonato.partidas) {
      if (p.finalizada) {
        for (var ev in p.eventos) {
          if (ev.tipo == 'gol') {
            final key = '${ev.nomeJogador}_${ev.timeId}';
            if (!artilheirosMap.containsKey(key)) {
              final timeObj = widget.campeonato.times.firstWhere(
                (t) => t.id == ev.timeId,
                orElse: () => Time(id: '', nome: 'Time Desconhecido', fundacao: '', jogadores: []),
              );
              artilheirosMap[key] = {
                'nome': ev.nomeJogador,
                'time': timeObj.nome,
                'gols': 0,
              };
            }
            artilheirosMap[key]!['gols'] = (artilheirosMap[key]!['gols'] as int) + 1;
          }
        }
      }
    }

    final lista = artilheirosMap.values.toList();
    lista.sort((a, b) => (b['gols'] as int).compareTo(a['gols'] as int));
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final artilharia = _calcularArtilharia();

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.campeonato.nome),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.sports_soccer), text: 'Partidas'),
              Tab(icon: Icon(Icons.table_chart), text: 'Classificação'),
              Tab(icon: Icon(Icons.groups), text: 'Equipes & Atletas'),
              Tab(icon: Icon(Icons.emoji_events), text: 'Artilharia'),
              Tab(icon: Icon(Icons.info_outline), text: 'Informações'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. PARTIDAS
            PartidasTab(
              campeonato: widget.campeonato,
              onDataChanged: _atualizar,
            ),

            // 2. CLASSIFICAÇÃO
            ClassificacaoTab(campeonato: widget.campeonato),

            // 3. EQUIPES & ATLETAS (Estrutura original com botão de Nova Equipe e lista expandível)
            Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: _modalAdicionarTime,
                icon: const Icon(Icons.add),
                label: const Text('Nova Equipe'),
              ),
              body: widget.campeonato.times.isEmpty
                  ? const Center(
                      child: Text('Nenhuma equipe cadastrada.\nClique em "+ Nova Equipe" para adicionar.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: widget.campeonato.times.length,
                      itemBuilder: (ctx, i) {
                        final time = widget.campeonato.times[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ExpansionTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.shield),
                            ),
                            title: Text(
                              time.nome,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Fundação/Bairro: ${time.fundacao.isEmpty ? "N/I" : time.fundacao} • ${time.jogadores.length} atletas',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.person_add, color: Colors.indigo),
                              tooltip: 'Adicionar Atleta',
                              onPressed: () => _modalSalvarJogador(time),
                            ),
                            children: [
                              if (time.jogadores.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('Nenhum atleta cadastrado neste time.',
                                      style: TextStyle(color: Colors.grey)),
                                )
                              else
                                ...time.jogadores.map(
                                  (j) => ListTile(
                                    dense: true,
                                    leading: CircleAvatar(
                                      radius: 12,
                                      child: Text(
                                        j.numeroCamisa > 0 ? '${j.numeroCamisa}' : 'J',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                    title: Text(j.nome, style: const TextStyle(fontWeight: FontWeight.w500)),
                                    subtitle: Text(j.posicao.isEmpty ? 'Sem posição definida' : j.posicao),
                                    onTap: () => _modalSalvarJogador(time, jogadorExistente: j),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // 4. ARTILHARIA
            artilharia.isEmpty
                ? const Center(
                    child: Text('Nenhum gol registrado até o momento.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: artilharia.length,
                    itemBuilder: (ctx, index) {
                      final item = artilharia[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: index == 0 ? Colors.amber : Colors.grey.shade300,
                          child: Text(
                            '${index + 1}º',
                            style: TextStyle(
                              color: index == 0 ? Colors.black : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(item['nome'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(item['time']),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${item['gols']} gol(s)',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                      );
                    },
                  ),

            // 5. INFORMAÇÕES
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.campeonato.nome,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text('Organizador: ${widget.campeonato.organizador}'),
                      const SizedBox(height: 6),
                      Text('Modalidade: ${widget.campeonato.modalidade.nomeExibicao}'),
                      const SizedBox(height: 6),
                      Text('Modelo do Campeonato: ${widget.campeonato.modelo.nomeExibicao}'),
                      const SizedBox(height: 6),
                      Text('Total de Equipes: ${widget.campeonato.times.length}'),
                      const SizedBox(height: 6),
                      Text('Total de Partidas: ${widget.campeonato.partidas.length}'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}