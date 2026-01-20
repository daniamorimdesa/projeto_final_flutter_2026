import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _handleLogout(BuildContext context) {
    // Limpar o estado do usuário (logout)
    context.read<LoginStore>().logout();

    // Navegar de volta para o login substituindo a página atual
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Bem-vindo à Home!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Login realizado com sucesso!',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _handleLogout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Sair / Voltar para Login'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF6A1B9A),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
