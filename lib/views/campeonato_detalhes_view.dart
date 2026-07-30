import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/campeonato_models.dart';

class CampeonatoDetalhesView extends StatefulWidget {
  const CampeonatoDetalhesView({super.key, required this.campeonato});

  final Campeonato campeonato;

  @override
  State<CampeonatoDetalhesView> createState() => _CampeonatoDetalhesViewState();
}

class _CampeonatoDetalhesViewState extends State<CampeonatoDetalhesView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Agora as listas começam completamente vazias para você controlar tudo!
  final List<Time> _times = [];
  final List<Jogo> _jogos = [];
  
  final Uuid _uuid = const Uuid();
  final TextEditingController _nomeTimeController = TextEditingController();
  final TextEditingController _nomeJogadorController = TextEditingController();
  final TextEditingController _golsCasaController = TextEditingController();
  final TextEditingController _golsForaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nomeTimeController.dispose();
    _nomeJogadorController.dispose();
    _golsCasaController.dispose();
    _golsForaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campeonato.nome.toUpperCase()),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.emoji_events), text: "Formato"),
            Tab(icon: Icon(Icons.table_rows), text: "Classificação"),
            Tab(icon: Icon(Icons.sports_soccer), text: "Jogos"),
            Tab(icon: Icon(Icons.people), text: "Times"),
            Tab(icon: Icon(Icons.star), text: "Artilharia"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFormatoView(),
          _buildClassificacaoView(),
          _buildJogosView(),
          _buildTimesView(),
          _buildArtilhariaView(),
        ],
      ),
    );
  }

  Widget _buildFormatoView() {
    return const Center(child: Text("Configurações do Formato do Campeonato"));
  }

  // --- TABELA DE CLASSIFICAÇÃO AUTOMÁTICA ---
  Widget _buildClassificacaoView() {
    if (_times.isEmpty) {
      return const Center(child: Text("Cadastre times na aba 'Times' para ver a classificação.", style: TextStyle(color: Colors.grey)));
    }

    List<LinhaClassificacaoAux> tabela = _times.map((t) => LinhaClassificacaoAux(time: t)).toList();

    for (var jogo in _jogos) {
      if (jogo.encerrado && jogo.golsCasa != null && jogo.golsFora != null) {
        var linhaCasa = tabela.firstWhere((l) => l.time.id == jogo.timeCasa.id);
        var linhaFora = tabela.firstWhere((l) => l.time.id == jogo.timeFora.id);

        linhaCasa.jogos++;
        linhaFora.jogos++;

        if (jogo.golsCasa! > jogo.golsFora!) {
          linhaCasa.pontos += 3;
          linhaCasa.vitorias++;
          linhaFora.derrotas++;
        } else if (jogo.golsCasa! < jogo.golsFora!) {
          linhaFora.pontos += 3;
          linhaFora.vitorias++;
          linhaCasa.derrotas++;
        } else {
          linhaCasa.pontos += 1;
          linhaFora.pontos += 1;
          linhaCasa.empates++;
          linhaFora.empates++;
        }
      }
    }

    tabela.sort((a, b) => b.pontos.compareTo(a.pontos));

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tabela.length,
      itemBuilder: (context, index) {
        final item = tabela[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF0F172A),
              foregroundColor: Colors.white,
              child: Text("${index + 1}"),
            ),
            title: Text(item.time.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("P: ${item.pontos} | J: ${item.jogos} | V: ${item.vitorias} | E: ${item.empates} | D: ${item.derrotas}"),
          ),
        );
      },
    );
  }

  // --- ABA DE JOGOS ---
  Widget _buildJogosView() {
    return Scaffold(
      body: _jogos.isEmpty
          ? const Center(child: Text("Nenhum jogo cadastrado nesta competição.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _jogos.length,
              itemBuilder: (context, index) {
                final jogo = _jogos[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => _exibirDialogoPlacar(jogo),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(jogo.timeCasa.nome, textAlign: TextAlign.right, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16.0),
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: jogo.encerrado ? const Color(0xFF22C55E).withValues(alpha: 0.1) : Colors.grey[200],
                              border: jogo.encerrado ? Border.all(color: const Color(0xFF22C55E)) : null,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              jogo.encerrado ? "${jogo.golsCasa} x ${jogo.golsFora}" : "vs",
                              style: TextStyle(fontWeight: FontWeight.bold, color: jogo.encerrado ? const Color(0xFF15803D) : Colors.black, fontSize: 16),
                            ),
                          ),
                          Expanded(child: Text(jogo.timeFora.nome, textAlign: TextAlign.left, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        onPressed: _exibirDialogoAdicionarJogo,
        child: const Icon(Icons.add),
      ),
    );
  }

  // --- ABA DE TIMES (COM CADASTRO DE JOGADORES) ---
  Widget _buildTimesView() {
    return Scaffold(
      body: _times.isEmpty
          ? const Center(child: Text("Nenhum time inscrito neste campeonato.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _times.length,
              itemBuilder: (context, index) {
                final time = _times[index];
                return Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.shield, color: Color(0xFF0F172A)),
                    title: Text(time.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${time.jogadores.length} jogadores inscritos"),
                    trailing: IconButton(
                      icon: const Icon(Icons.person_add, color: Color(0xFF0F172A)),
                      onPressed: () => _exibirDialogoAdicionarJogador(time),
                    ),
                    children: time.jogadores.isEmpty 
                      ? [const Padding(padding: EdgeInsets.all(8.0), child: Text("Nenhum jogador neste elenco", style: TextStyle(color: Colors.grey, fontSize: 12)))]
                      : time.jogadores.map((j) => ListTile(
                          dense: true,
                          leading: const Icon(Icons.person, size: 18),
                          title: Text(j.nome),
                          trailing: Text("${j.gols} gols", style: const TextStyle(color: Colors.grey)),
                        )).toList(),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        onPressed: _exibirDialogoAdicionarTime,
        child: const Icon(Icons.add),
      ),
    );
  }

  // --- TABELA DE ARTILHARIA REAL ---
  Widget _buildArtilhariaView() {
    List<Map<String, dynamic>> listaArtilheiros = [];
    
    for (var time in _times) {
      for (var jogador in time.jogadores) {
        if (jogador.gols > 0) {
          listaArtilheiros.add({
            'nome': jogador.nome,
            'time': time.nome,
            'gols': jogador.gols,
          });
        }
      }
    }

    listaArtilheiros.sort((a, b) => b['gols'].compareTo(a['gols']));

    if (listaArtilheiros.isEmpty) {
      return const Center(child: Text("Nenhum gol marcado no campeonato ainda.", style: TextStyle(color: Colors.grey)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: listaArtilheiros.length,
      itemBuilder: (context, index) {
        final artilheiro = listaArtilheiros[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: Text("${index + 1}º", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            title: Text(artilheiro['nome'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(artilheiro['time'], style: const TextStyle(color: Colors.grey)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(20)),
              child: Text("${artilheiro['gols']} Gols", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }

  // --- DIÁLOGOS DE CADASTRO ---

  void _exibirDialogoAdicionarTime() {
    _nomeTimeController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Adicionar Time"),
        content: TextField(controller: _nomeTimeController, decoration: const InputDecoration(labelText: "Nome do Time"), autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
            onPressed: () {
              if (_nomeTimeController.text.trim().isNotEmpty) {
                setState(() {
                  _times.add(Time(id: _uuid.v4(), nome: _nomeTimeController.text.trim()));
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Salvar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _exibirDialogoAdicionarJogador(Time time) {
    _nomeJogadorController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Inscrição no ${time.nome}"),
        content: TextField(controller: _nomeJogadorController, decoration: const InputDecoration(labelText: "Nome do Jogador"), autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
            onPressed: () {
              if (_nomeJogadorController.text.trim().isNotEmpty) {
                setState(() {
                  time.jogadores.add(Jogador(id: _uuid.v4(), nome: _nomeJogadorController.text.trim()));
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Adicionar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _exibirDialogoAdicionarJogo() {
    if (_times.length < 2) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Aviso"),
          content: const Text("Cadastre pelo menos 2 times para criar um jogo."),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Entendi"))],
        ),
      );
      return;
    }

    Time? timeCasaSelecionado = _times[0];
    Time? timeForaSelecionado = _times[1];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setPopupState) => AlertDialog(
          title: const Text("Novo Confronto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Time>(
                value: timeCasaSelecionado,
                isExpanded: true,
                items: _times.map((t) => DropdownMenuItem(value: t, child: Text(t.nome))).toList(),
                onChanged: (v) => setPopupState(() => timeCasaSelecionado = v),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Text("VS")),
              DropdownButton<Time>(
                value: timeForaSelecionado,
                isExpanded: true,
                items: _times.map((t) => DropdownMenuItem(value: t, child: Text(t.nome))).toList(),
                onChanged: (v) => setPopupState(() => timeForaSelecionado = v),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
              onPressed: () {
                if (timeCasaSelecionado == timeForaSelecionado) return;
                setState(() {
                  _jogos.add(Jogo(id: _uuid.v4(), timeCasa: timeCasaSelecionado!, timeFora: timeForaSelecionado!));
                });
                Navigator.pop(context);
              },
              child: const Text("Criar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // --- LANÇAR PLACAR E DISTRIBUIR GOLS ---
  void _exibirDialogoPlacar(Jogo jogo) {
    _golsCasaController.text = jogo.golsCasa?.toString() ?? "";
    _golsForaController.text = jogo.golsFora?.toString() ?? "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Informar Placar", textAlign: TextAlign.center),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(jogo.timeCasa.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextField(controller: _golsCasaController, keyboardType: TextInputType.number, textAlign: TextAlign.center),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(12.0), child: Text("X")),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(jogo.timeFora.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextField(controller: _golsForaController, keyboardType: TextInputType.number, textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
            onPressed: () {
              final int? gc = int.tryParse(_golsCasaController.text);
              final int? gf = int.tryParse(_golsForaController.text);

              if (gc != null && gf != null) {
                Navigator.pop(context);
                _exibirDialogoQuemFezOsGols(jogo, gc, gf);
              }
            },
            child: const Text("Próximo", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _exibirDialogoQuemFezOsGols(Jogo jogo, int golsCasa, int golsFora) {
    List<String> temporarioArtilheiros = [];

    // Junta os jogadores que podem ter marcado gols nesse jogo
    List<Jogador> jogadoresDisponiveis = [...jogo.timeCasa.jogadores, ...jogo.timeFora.jogadores];

    if (jogadoresDisponiveis.isEmpty || (golsCasa == 0 && golsFora == 0)) {
      // Se não há jogadores cadastrados ou o jogo foi 0x0, salva direto
      _salvarPartidaFim(jogo, golsCasa, golsFora, []);
      return;
    }

    int totalGolsEsperados = golsCasa + golsFora;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setPopupState) => AlertDialog(
          title: Text("Quem fez os $totalGolsEsperados gols?"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jogadoresDisponiveis.length,
              itemBuilder: (context, i) {
                final jog = jogadoresDisponiveis[i];
                int quantosDesse = temporarioArtilheiros.where((id) => id == jog.id).length;

                return ListTile(
                  title: Text(jog.nome),
                  subtitle: Text(jogo.timeCasa.jogadores.contains(jog) ? jogo.timeCasa.nome : jogo.timeFora.nome),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: quantosDesse > 0 ? () => setPopupState(() => temporarioArtilheiros.remove(jog.id)) : null,
                      ),
                      Text("$quantosDesse", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                        onPressed: temporarioArtilheiros.length < totalGolsEsperados 
                          ? () => setPopupState(() => temporarioArtilheiros.add(jog.id)) 
                          : null,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Voltar")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
              onPressed: temporarioArtilheiros.length == totalGolsEsperados
                ? () {
                    _salvarPartidaFim(jogo, golsCasa, golsFora, temporarioArtilheiros);
                    Navigator.pop(context);
                  }
                : null, // Só deixa salvar se distribuir todos os gols digitados no placar
              child: const Text("Finalizar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarPartidaFim(Jogo jogo, int gc, int gf, List<String> artilheirosDoJogo) {
    setState(() {
      // 1. Remove gols antigos se for uma reedição de placar
      for (var id in jogo.idArtilheiros) {
        for (var t in _times) {
          for (var j in t.jogadores) {
            if (j.id == id) j.gols--;
          }
        }
      }

      // 2. Salva o novo placar
      jogo.golsCasa = gc;
      jogo.golsFora = gf;
      jogo.encerrado = true;
      jogo.idArtilheiros.clear();
      jogo.idArtilheiros.addAll(artilheirosDoJogo);

      // 3. Computa os gols novos para os jogadores correspondentes
      for (var id in artilheirosDoJogo) {
        for (var t in _times) {
          for (var j in t.jogadores) {
            if (j.id == id) j.gols++;
          }
        }
      }
    });
  }
}

class LinhaClassificacaoAux {
  final Time time;
  int pontos = 0;
  int jogos = 0;
  int vitorias = 0;
  int empates = 0;
  int derrotas = 0;

  LinhaClassificacaoAux({required this.time});
}