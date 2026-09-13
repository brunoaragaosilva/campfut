import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Retorna o usuário logado atualmente
  User? get currentUser => _auth.currentUser;

  // Monitora se o usuário está logado ou deslogado em tempo real
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Função para fazer Login
  Future<UserCredential?> loginComEmail({
    required String email,
    required String senha,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Erro ao realizar login.');
    }
  }

  // Função para Criar Conta
  Future<UserCredential?> cadastrarComEmail({
    required String email,
    required String senha,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Erro ao cadastrar usuário.');
    }
  }

  // Função para Sair da Conta
  Future<void> deslogar() async {
    await _auth.signOut();
  }
}