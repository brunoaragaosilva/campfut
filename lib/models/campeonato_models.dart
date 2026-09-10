import 'package:flutter/material.dart';

enum ModalidadeEsportiva {
  futebol,
  futsal,
  futebol7,
  handebol,
  basquetebol,
  volei,
  voleiDePraia,
  tenisDeMesa,
  tenis,
  beachTennis,
  xadrez,
  atletismo,
  esporteGenerico,
}

extension ModalidadeEsportivaExtension on ModalidadeEsportiva {
  String get nomeExibicao {
    switch (this) {
      case ModalidadeEsportiva.futebol:
        return 'Futebol';
      case ModalidadeEsportiva.futsal:
        return 'Futsal';
      case ModalidadeEsportiva.futebol7:
        return 'Futebol 7';
      case ModalidadeEsportiva.handebol:
        return 'Handebol';
      case ModalidadeEsportiva.basquetebol:
        return 'Basquetebol';
      case ModalidadeEsportiva.volei:
        return 'Vôlei';
      case ModalidadeEsportiva.voleiDePraia:
        return 'Vôlei de Praia';
      case ModalidadeEsportiva.tenisDeMesa:
        return 'Tênis de Mesa';
      case ModalidadeEsportiva.tenis:
        return 'Tênis';
      case ModalidadeEsportiva.beachTennis:
        return 'Beach Tennis';
      case ModalidadeEsportiva.xadrez:
        return 'Xadrez';
      case ModalidadeEsportiva.atletismo:
        return 'Atletismo';
      case ModalidadeEsportiva.esporteGenerico:
        return 'Esporte Genérico';
    }
  }
}

enum ModeloCampeonato { pontosCorridos, mataMata, gruposEMataMata }

extension ModeloCampeonatoExtension on ModeloCampeonato {
  String get nomeExibicao {
    switch (this) {
      case ModeloCampeonato.pontosCorridos:
        return 'Pontos Corridos';
      case ModeloCampeonato.mataMata:
        return 'Mata-Mata';
      case ModeloCampeonato.gruposEMataMata:
        return 'Grupos + Mata-Mata';
    }
  }
}

class Jogador {
  final String id;
  String nome;
  String posicao;
  int numeroCamisa;

  Jogador({
    required this.id,
    required this.nome,
    required this.posicao,
    required this.numeroCamisa,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'posicao': posicao,
        'numeroCamisa': numeroCamisa,
      };

  factory Jogador.fromJson(Map<String, dynamic> json) => Jogador(
        id: json['id'] ?? '',
        nome: json['nome'] ?? '',
        posicao: json['posicao'] ?? '',
        numeroCamisa: json['numeroCamisa'] ?? 0,
      );
}

class Time {
  final String id;
  String nome;
  String fundacao;
  List<Jogador> jogadores;

  Time({
    required this.id,
    required this.nome,
    required this.fundacao,
    required this.jogadores,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'fundacao': fundacao,
        'jogadores': jogadores.map((j) => j.toJson()).toList(),
      };

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json['id'] ?? '',
        nome: json['nome'] ?? '',
        fundacao: json['fundacao'] ?? '',
        jogadores: json['jogadores'] != null
            ? (json['jogadores'] as List)
                .map((j) => Jogador.fromJson(j))
                .toList()
            : [],
      );
}

class EventoPartida {
  final String nomeJogador;
  final String tipo; // 'gol', 'amarelo', 'vermelho'
  final String timeId;

  EventoPartida({
    required this.nomeJogador,
    required this.tipo,
    required this.timeId,
  });

  Map<String, dynamic> toJson() => {
        'nomeJogador': nomeJogador,
        'tipo': tipo,
        'timeId': timeId,
      };

  factory EventoPartida.fromJson(Map<String, dynamic> json) => EventoPartida(
        nomeJogador: json['nomeJogador'] ?? '',
        tipo: json['tipo'] ?? '',
        timeId: json['timeId'] ?? '',
      );
}

class Partida {
  final String id;
  final String timeMandanteId;
  final String timeVisitanteId;
  final int rodada;
  final DateTime data;
  final String local;
  int? golsMandante;
  int? golsVisitante;
  bool finalizada;
  List<EventoPartida> eventos;

  Partida({
    required this.id,
    required this.timeMandanteId,
    required this.timeVisitanteId,
    required this.rodada,
    required this.data,
    required this.local,
    this.golsMandante,
    this.golsVisitante,
    this.finalizada = false,
    List<EventoPartida>? eventos,
  }) : eventos = eventos ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'timeMandanteId': timeMandanteId,
        'timeVisitanteId': timeVisitanteId,
        'rodada': rodada,
        'data': data.toIso8601String(),
        'local': local,
        'golsMandante': golsMandante,
        'golsVisitante': golsVisitante,
        'finalizada': finalizada,
        'eventos': eventos.map((e) => e.toJson()).toList(),
      };

  factory Partida.fromJson(Map<String, dynamic> json) => Partida(
        id: json['id'],
        timeMandanteId: json['timeMandanteId'],
        timeVisitanteId: json['timeVisitanteId'],
        rodada: json['rodada'],
        data: DateTime.parse(json['data']),
        local: json['local'],
        golsMandante: json['golsMandante'],
        golsVisitante: json['golsVisitante'],
        finalizada: json['finalizada'] ?? false,
        eventos: json['eventos'] != null
            ? (json['eventos'] as List)
                .map((e) => EventoPartida.fromJson(e))
                .toList()
            : [],
      );
}

class Campeonato {
  final String id;
  String nome;
  String organizador;
  ModalidadeEsportiva modalidade;
  ModeloCampeonato modelo;
  List<Time> times;
  List<Partida> partidas;

  Campeonato({
    required this.id,
    required this.nome,
    required this.organizador,
    required this.modalidade,
    required this.modelo,
    required this.times,
    required this.partidas,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'organizador': organizador,
        'modalidade': modalidade.index,
        'modelo': modelo.index,
        'times': times.map((t) => t.toJson()).toList(),
        'partidas': partidas.map((p) => p.toJson()).toList(),
      };

  factory Campeonato.fromJson(Map<String, dynamic> json) => Campeonato(
        id: json['id'] ?? '',
        nome: json['nome'] ?? '',
        organizador: json['organizador'] ?? '',
        modalidade: ModalidadeEsportiva.values[json['modalidade'] ?? 0],
        modelo: ModeloCampeonato.values[json['modelo'] ?? 0],
        times: json['times'] != null
            ? (json['times'] as List).map((t) => Time.fromJson(t)).toList()
            : [],
        partidas: json['partidas'] != null
            ? (json['partidas'] as List)
                .map((p) => Partida.fromJson(p))
                .toList()
            : [],
      );
}