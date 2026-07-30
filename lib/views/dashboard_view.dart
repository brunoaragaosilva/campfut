import 'package:flutter/material.dart';
import 'novo_campeonato.dart';
import 'meus_campeonatos_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Fundo escuro elegante da Dashboard
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo do CAMPFUT
                Image.asset(
                  'assets/images/logo_campfut.png',
                  height: 160,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.emoji_events,
                      size: 100,
                      color: Colors.amber,
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Título Principal
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    children: [
                      TextSpan(text: 'GESTÃO DE '),
                      TextSpan(
                        text: 'ESPORTES\n',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      TextSpan(text: 'COM ENTRETENIMENTO E '),
                      TextSpan(
                        text: 'LAZER',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Botão "CRIAR CAMPEONATO" Integrado
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      NovoCampeonatoModal.exibir(context, (novoCampeonato) {
                        // Após criar o campeonato, navega para a lista de "Meus Campeonatos"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeusCampeonatosView(),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C853),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'CRIAR CAMPEONATO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Subtítulo de Funcionalidades
                const Text(
                  'ORGANIZAÇÃO - TÁTICA - REGRAS - ADMINISTRAÇÃO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 40),

                // Seção de Patrocínio
                const Text(
                  'PATROCÍNIO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // Cards de Patrocinadores
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Expanded(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'PATROCÍNIO',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}