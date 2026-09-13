import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _termsAccepted = false;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Validação centralizada dos termos de uso antes de qualquer ação de auth
  bool _validarTermosOuExibirPopup() {
    if (!_termsAccepted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Você precisa aceitar os termos de uso'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Termos e condições de uso'),
              SizedBox(height: 8),
              Text('Confirmo que li e aceito os termos e condições de uso do Aplicativo', style: TextStyle(fontSize: 12)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() => _termsAccepted = true);
                Navigator.pop(context);
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  void _handleLogin() async {
    if (!_validarTermosOuExibirPopup()) return;

    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o usuário/e-mail e a senha.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: _userController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );
    } on FirebaseAuthException catch (e) {
      String mensagemErro = 'Erro ao realizar login.';
      if (e.code == 'user-not-found') {
        mensagemErro = 'Usuário não encontrado.';
      } else if (e.code == 'wrong-password') {
        mensagemErro = 'Senha incorreta.';
      } else if (e.code == 'invalid-email') {
        mensagemErro = 'E-mail inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagemErro)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleCriarConta() async {
    if (!_validarTermosOuExibirPopup()) return;

    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o e-mail e a senha desejada para o cadastro.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _userController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada com sucesso!')),
      );
    } on FirebaseAuthException catch (e) {
      String mensagemErro = 'Erro ao cadastrar usuário.';
      if (e.code == 'email-already-in-use') {
        mensagemErro = 'Este e-mail já está cadastrado.';
      } else if (e.code == 'weak-password') {
        mensagemErro = 'A senha é muito fraca.';
      } else if (e.code == 'invalid-email') {
        mensagemErro = 'E-mail inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagemErro)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleGoogleLogin() async {
    if (!_validarTermosOuExibirPopup()) return;

    setState(() => _isLoading = true);

    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      // Executa o popup de login com Google otimizado para Web / GitHub Pages
      await _auth.signInWithPopup(googleProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login com Google realizado com sucesso!')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erro ao autenticar com o Google.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Column(
        children: [
          // Barra Superior original
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFF0B132B),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Colors.white),
                Row(
                  children: const [
                    Text(
                      'CAMPFUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text('⚽', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.add_circle_outline, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text(
                      'Acessar / Criar',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Container Central de Login
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8F3DC).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0B132B),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
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
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: _userController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: const InputDecoration(
                                labelText: 'Usuário',
                                labelStyle: TextStyle(color: Colors.black54),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black87),
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                labelStyle: TextStyle(color: Colors.black54),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: _isLoading ? null : _handleCriarConta,
                                  child: const Text(
                                    'Criar conta',
                                    style: TextStyle(
                                      color: Color(0xFF1D3557),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0B132B),
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                      : const Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            OutlinedButton.icon(
                              onPressed: _isLoading ? null : _handleGoogleLogin,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                side: const BorderSide(color: Colors.black26),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Text('G', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                              label: const Text(
                                'Entrar com Google',
                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Termos e condições de uso',
                                      style: TextStyle(
                                        color: Color(0xFF1D3557),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Política de privacidade',
                                      style: TextStyle(
                                        color: Color(0xFF1D3557),
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: _termsAccepted,
                                  onChanged: (val) {
                                    setState(() => _termsAccepted = val ?? false);
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'Confirmo que li e aceito os termos e condições de uso do Aplicativo',
                                    style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Rodapé original
          Container(
            padding: const EdgeInsets.all(12),
            child: const Text(
              'ORGANIZAÇÃO - TÁTICA - REGRAS - ADMINISTRAÇÃO',
              style: TextStyle(color: Colors.white67, fontSize: 11, letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}