class Campeonato {
  String id;
  String nome;
  ModeloCampeonato modelo;
  String regulamentoDescricao;
  List<Time> times;
  List<Partida> partidas;

  Campeonato({
    required this.id,
    required this.nome,
    required this.modelo,
    required this.regulamentoDescricao,
    required this.times,
    required this.partidas,
  });
}

enum ModeloCampeonato { pontosCorridos, mataMata, misto }

class Time {
  String id;
  String nome;
  String fundacao;
  List<Jogador> jogadores;

  Time({
    required this.id,
    required this.nome,
    required this.fundacao,
    required this.jogadores,
  });
}

class Jogador {
  String id;
  String nome;
  String posicao;
  int numeroCamisa;
  int gols;

  Jogador({
    required this.id,
    required this.nome,
    required this.posicao,
    required this.numeroCamisa,
    this.gols = 0,
  });
}

class Partida {
  String id;
  String timeA;
  String timeB;
  String data;      // Removido o 'final' para permitir edição
  String horario;   // Removido o 'final' para permitir edição
  String local;     // Removido o 'final' para permitir edição
  int golsTimeA;
  int golsTimeB;
  bool realizada;

  Partida({
    required this.id,
    required this.timeA,
    required this.timeB,
    required this.data,
    required this.horario,
    required this.local,
    this.golsTimeA = 0,
    this.golsTimeB = 0,
    this.realizada = false,
  });
}