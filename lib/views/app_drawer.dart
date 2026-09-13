import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final bool isLogged;
  final String userName;
  final VoidCallback? onLoginTap;
  final VoidCallback onLogout;

  const AppDrawer({
    super.key,
    required this.isLogged,
    required this.userName,
    this.onLoginTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle tileTextStyle = TextStyle(
      color: Colors.black87,
      fontSize: 14,
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFAF8FC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
              decoration: const BoxDecoration(
                color: Color(0xFF26C6DA),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey, size: 36),
                  ),
                  const SizedBox(height: 12),
                  if (!isLogged)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        if (onLoginTap != null) onLoginTap!();
                      },
                      child: const Text(
                        'Fazer Login',
                        style: TextStyle(
                          color: Color(0xFF0A1D44),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Color(0xFF0A1D44),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  const Text(
                    'Acesse para gerenciar\nseus campeonatos',
                    style: TextStyle(color: Color(0xFF0A1D44), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                'Campeonatos',
                style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events_outlined, color: Colors.black54),
              title: const Text('Organizar campeonatos', style: tileTextStyle),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border, color: Colors.black54),
              title: const Text('Campeonatos seguindo', style: tileTextStyle),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people_outline, color: Colors.black54),
              title: const Text('Organizadores que sigo', style: tileTextStyle),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.link, color: Colors.black54),
              title: const Text('Abrir link', style: tileTextStyle),
              onTap: () {},
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: Text(
                'Ajuda',
                style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contacts_outlined, color: Colors.black54),
              title: const Text('Contatos', style: tileTextStyle),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.slideshow, color: Colors.black54),
              title: const Text('Youtube', style: tileTextStyle),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.article_outlined, color: Colors.black54),
              title: const Text('Termos e condições de uso', style: tileTextStyle),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined, color: Colors.black54),
              title: const Text('Política de privacidade', style: tileTextStyle),
              onTap: () {},
            ),
            if (isLogged)
              ListTile(
                leading: const Icon(Icons.arrow_back, color: Colors.black54),
                title: const Text('Sair', style: tileTextStyle),
                onTap: onLogout,
              ),
          ],
        ),
      ),
    );
  }
}