import 'package:flutter/material.dart';
import 'app_drawer.dart';
import 'meus_campeonatos_view.dart';

class HomeLandingView extends StatefulWidget {
  const HomeLandingView({super.key});

  @override
  State<HomeLandingView> createState() => _HomeLandingViewState();
}

class _HomeLandingViewState extends State<HomeLandingView> {
  bool _isLogged = false;
  final String _userName = "Bruno Aragão";

  void _abrirModalLogin() {
    bool aceitouTermos = false;
    final usuarioCtrl = TextEditingController();
    final senhaCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, // Evita fechar o modal sem querer ao clicar fora
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: const Color(0xFFD3ECEC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400), // Mantém o modal elegante em telas grandes/web
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 48), // Espaçador para centralizar o título
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0A1D44),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black54),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: usuarioCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: senhaCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Lógica para ir para tela de criar conta futuramente
                            },
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A1D44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (!aceitouTermos) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Aceite os termos para continuar.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                _isLogged = true;
                              });
                              Navigator.pop(ctx);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MeusCampeonatosView(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                        label: const Text(
                          'Entrar com Google',
                          style: TextStyle(color: Colors.black87),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Termos e condições de uso\nPolítica de privacidade',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF00838F), fontSize: 11),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: aceitouTermos,
                            onChanged: (val) {
                              setModalState(() {
                                aceitouTermos = val ?? false;
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Confirmo que li e aceito os termos e condições de uso do Aplicativo',
                              style: TextStyle(fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle baseStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      height: 1.25,
      letterSpacing: 0.5,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F232A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1D44),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('CAMPFUT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            SizedBox(width: 4),
            Icon(Icons.sports_soccer, size: 18, color: Colors.white),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Garante que o ícone do menu (hamburguer) fique branco
        actions: [
          TextButton.icon(
            onPressed: _abrirModalLogin,
            icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 18),
            label: const Text(
              'Acessar / Criar',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
        isLogged: _isLogged,
        userName: _userName,
        onLoginTap: _abrirModalLogin,
        onLogout: () {
          setState(() => _isLogged = false);
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: Image.asset(
                'assets/images/logo_campfut.png',
                height: 210,
                errorBuilder: (ctx, err, stack) => const Icon(
                  Icons.shield,
                  size: 140,
                  color: Color(0xFF00BCD4),
                ),
              ),
            ),
            const SizedBox(height: 28),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: baseStyle,
                children: [
                  TextSpan(
                    text: 'GESTÃO DE ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'ESPORTES',
                    style: TextStyle(color: Color(0xFF7A8A96)),
                  ),
                  TextSpan(
                    text: '\nCOM ENTRETENIMENTO E ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'LAZER',
                    style: TextStyle(color: Color(0xFF7A8A96)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 280,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF26C6DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_isLogged) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MeusCampeonatosView(),
                      ),
                    );
                  } else {
                    _abrirModalLogin();
                  }
                },
                child: const Text(
                  'CRIAR CAMPEONATO',
                  style: TextStyle(
                    color: Color(0xFF0A1D44),
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'ORGANIZAÇÃO - TÁTICA - REGRAS - ADMINISTRAÇÃO',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              'PATROCÍNIO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'PATROCÍNIO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
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