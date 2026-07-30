import 'package:flutter/material.dart';

class MeusCampeonatosView extends StatefulWidget {
  const MeusCampeonatosView({super.key});

  @override
  State<MeusCampeonatosView> createState() => _MeusCampeonatosViewState();
}

class _MeusCampeonatosViewState extends State<MeusCampeonatosView> {
  // Controle para abrir/fechar a aba inferior da Página do Organizador
  bool _mostrarPaginaOrganizador = false;

  // Controllers para os campos da Página do Organizador
  final TextEditingController _organizadorController =
  TextEditingController(text: 'Bruno Aragão');
  final TextEditingController _texto1Controller = TextEditingController();
  final TextEditingController _texto2Controller = TextEditingController();
  final TextEditingController _sobreController = TextEditingController();
  final TextEditingController _linkController = TextEditingController(text: 'ruus');

  String _privacidade = 'Privado';
  String _formatoDisputa = 'Presencial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10B981),
        title: const Text(
          'Meus campeonatos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // CONTEÚDO PRINCIPAL (LISTA E BOTÃO NOVO)
          Column(
            children: [
              const SizedBox(height: 16),
              // BOTÃO NOVO CAMPEONATO
              Center(
                child: ElevatedButton(
                  onPressed: () => _exibirModalNovoCampeonato(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Novo campeonato',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // LISTA DE CAMPEONATOS
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildItemCampeonato(
                      titulo: 'GFut Premium 40+',
                      subtitulo: 'Campeonato de futebol Society 40+',
                      seguidores: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ABA INFERIOR: PÁGINA DO ORGANIZADOR
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: 0,
            height: _mostrarPaginaOrganizador
                ? MediaQuery.of(context).size.height * 0.85
                : 50,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // CABEÇALHO DA ABA (CLICÁVEL PARA EXPANDIR)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _mostrarPaginaOrganizador = !_mostrarPaginaOrganizador;
                      });
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _mostrarPaginaOrganizador
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: const Color(0xFF10B981),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'PÁGINA DO ORGANIZADOR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),

                  // FORMULÁRIO DO ORGANIZADOR (QUANDO EXPANDIDO)
                  if (_mostrarPaginaOrganizador)
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // IMAGENS (FOTO PERFIL + CAPA)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // FOTO PERFIL 200x240
                                Container(
                                  width: 90,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF334155),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white24),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, color: Colors.white70),
                                      SizedBox(height: 4),
                                      Text(
                                        '200x240',
                                        style: TextStyle(
                                            color: Colors.white70, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // NOME ORGANIZADOR
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Organização do campeonato',
                                        style: TextStyle(
                                            color: Colors.white54, fontSize: 12),
                                      ),
                                      TextField(
                                        controller: _organizadorController,
                                        style:
                                        const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.white38),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFF10B981)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // BANNER CAPA 1440x482
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF334155),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white70),
                                  SizedBox(height: 4),
                                  Text(
                                    '1440x482',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // CAMPOS DE TEXTO E SOBRE
                            _buildCampoTexto('Texto 1', _texto1Controller, 70),
                            const SizedBox(height: 12),
                            _buildCampoTexto('Texto 2', _texto2Controller, 180),
                            const SizedBox(height: 12),
                            _buildCampoTexto('Sobre', _sobreController, 500,
                                maxLines: 3),
                            const SizedBox(height: 20),

                            // LINK DO SITE
                            const Text(
                              'Definir link do site',
                              style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text('https://campfut.com/ ',
                                    style: TextStyle(color: Colors.white70)),
                                Expanded(
                                  child: TextField(
                                    controller: _linkController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white38),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF10B981),
                              ),
                              child: const Text('Definir',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(height: 24),

                            // QUEM PODE VER?
                            const Text(
                              'Quem pode ver?',
                              style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.bold),
                            ),
                            RadioListTile<String>(
                              title: const Text('Privado',
                                  style: TextStyle(color: Colors.white)),
                              value: 'Privado',
                              groupValue: _privacidade,
                              activeColor: const Color(0xFF10B981),
                              onChanged: (val) =>
                                  setState(() => _privacidade = val!),
                            ),
                            RadioListTile<String>(
                              title: const Text('Público',
                                  style: TextStyle(color: Colors.white)),
                              subtitle: const Text(
                                  'Todos podem pesquisar e ver',
                                  style: TextStyle(color: Colors.white54)),
                              value: 'Público',
                              groupValue: _privacidade,
                              activeColor: const Color(0xFF10B981),
                              onChanged: (val) =>
                                  setState(() => _privacidade = val!),
                            ),

                            // ONDE ACONTECEM?
                            const SizedBox(height: 12),
                            const Text(
                              'Onde os campeonatos acontecem?',
                              style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.bold),
                            ),
                            RadioListTile<String>(
                              title: const Text('Campeonato disputado presencialmente',
                                  style: TextStyle(color: Colors.white)),
                              value: 'Presencial',
                              groupValue: _formatoDisputa,
                              activeColor: const Color(0xFF10B981),
                              onChanged: (val) =>
                                  setState(() => _formatoDisputa = val!),
                            ),
                            RadioListTile<String>(
                              title: const Text('Campeonato disputado na internet',
                                  style: TextStyle(color: Colors.white)),
                              value: 'Internet',
                              groupValue: _formatoDisputa,
                              activeColor: const Color(0xFF10B981),
                              onChanged: (val) =>
                                  setState(() => _formatoDisputa = val!),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // COMPONENTE: ITEM DA LISTA DE CAMPEONATOS
  Widget _buildItemCampeonato({
    required String titulo,
    required String subtitulo,
    required int seguidores,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // ESCUDO / LOGO DO TORNEIO
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF334155),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.emoji_events, color: Color(0xFF10B981)),
          ),
          const SizedBox(width: 12),
          // INFOS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitulo,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          // SEGUIDORES
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.copy, color: Colors.white38, size: 18),
              const SizedBox(height: 4),
              Text(
                '$seguidores seguidores',
                style: const TextStyle(color: Color(0xFF10B981), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // COMPONENTE: CAMPO DE TEXTO
  Widget _buildCampoTexto(
      String rotulo, TextEditingController controller, int limite,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: rotulo,
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF10B981)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '0/$limite',
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ),
      ],
    );
  }

  // MODAL NOVO CAMPEONATO (ÚNICO OU COM CATEGORIAS)
  void _exibirModalNovoCampeonato(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CAMPEONATO ÚNICO
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.emoji_events, color: Color(0xFF10B981), size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Campeonato único',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Campeonato de uma única modalidade com apenas 1 categoria',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.white12),

                // CAMPEONATO COM CATEGORIAS
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.add_box, color: Color(0xFF10B981), size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Campeonato com categorias',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Campeonato com mais de uma categoria. Ex: divisões por idade, masculino/feminino, diferentes esportes ou outras categorias',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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