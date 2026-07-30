import 'package:flutter/material.dart';
import 'meus_campeonatos_view.dart';

class AppDrawer extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback? onLoginTap;

  const AppDrawer({
    super.key,
    this.isLoggedIn = false, // Altere para true para testar o modo logado
    this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF1F1F5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // CABEÇALHO DINÂMICO
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 18),
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
              ),
            ),
            child: isLoggedIn ? _buildHeaderLogado() : _buildHeaderDeslogado(context),
          ),

          const SizedBox(height: 12),

          // SEÇÃO: CAMPEONATOS
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Campeonatos',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildMenuItem(
            icon: Icons.emoji_events_outlined,
            title: 'Organizar campeonatos',
            onTap: () {
              Navigator.pop(context); // Fecha o menu lateral
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeusCampeonatosView(),
                ),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.bookmark_border,
            title: 'Campeonatos seguindo',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.people_outline,
            title: 'Organizadores que sigo',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.link,
            title: 'Abrir link',
            onTap: () {},
          ),

          const SizedBox(height: 8),

          // SEÇÃO: AJUDA
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Ajuda',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildMenuItem(
            icon: Icons.contact_mail_outlined,
            title: 'Contatos',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.play_circle_outline,
            title: 'Youtube',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.article_outlined,
            title: 'Termos e condições de uso',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.article_outlined,
            title: 'Política de privacidade',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.undo,
            title: 'Sair',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // CABEÇALHO PARA USUÁRIO NÃO LOGADO
  Widget _buildHeaderDeslogado(BuildContext context) {
    return InkWell(
      onTap: onLoginTap ?? () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF475569),
                  size: 32,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Fazer Login',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Acesse para gerenciar\nseus campeonatos',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // CABEÇALHO PARA USUÁRIO LOGADO
  Widget _buildHeaderLogado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'FOTO',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'NOME USUÁRIO',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Perfil: Organizador',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFF0F4C3A),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_on,
            color: Color(0xFF10B981),
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      leading: Icon(icon, color: Colors.black54, size: 20),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}