class JogadorModel {
  String nome;
  String apelido;
  String posicao;
  String numeroCamisa;
  String documento;
  String dataNascimento;
  String telefone;
  String desde;

  JogadorModel({
    required this.nome,
    this.apelido = '',
    this.posicao = '',
    this.numeroCamisa = '',
    this.documento = '',
    this.dataNascimento = '',
    this.telefone = '',
    String? desde,
  }) : desde = desde ?? '11/09/2026';
}

class EquipeModel {
  String nome;
  String tecnico;
  List<JogadorModel> jogadores;
  List<String> equipeTecnica;

  EquipeModel({
    required this.nome,
    this.tecnico = '',
    List<JogadorModel>? jogadores,
    List<String>? equipeTecnica,
  })  : jogadores = jogadores ?? [],
        equipeTecnica = equipeTecnica ?? [];
}

class PartidaModel {
  String casa;
  String fora;
  int golsCasa;
  int golsFora;
  bool realizada;
  int faltasCasa;
  int faltasFora;

  PartidaModel({
    required this.casa,
    required this.fora,
    this.golsCasa = 0,
    this.golsFora = 0,
    this.realizada = false,
    this.faltasCasa = 0,
    this.faltasFora = 0,
  });
}