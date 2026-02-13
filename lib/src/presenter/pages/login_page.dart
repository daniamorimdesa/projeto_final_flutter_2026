// login_mobx_page.dart: Página de login com campos para nome de usuário e senha usando MobX para gerenciamento de estado

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:projeto_final_flutter_2026/src/presenter/pages/home_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/error_box.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

// widget da página de login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// estado da página de login
class _LoginPageState extends State<LoginPage> {
  // controladores para recuperar textos digitados
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // método para lidar com o login
  Future<void> _handleLogin() async {
    final loginStore = context.read<LoginStore>();

    loginStore.clearError(); // limpar erro antes de tentar logar

    final success = await loginStore.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (success && mounted) {
      final loggedUser = loginStore.user;

      // inicializar o UserStore com o usuário logado
      context.read<UserStore>().initUser(loggedUser);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  // liberar os controladores quando o widget for descartado
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // função helper para criar InputDecoration consistente
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.55), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  // construir o formulário de login
  Widget _buildLoginForm(BuildContext context) {
    final loginStore = context.read<LoginStore>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Entrar',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),

        TextField(
          controller: _usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Username'),
          onChanged: (_) => loginStore.clearError(),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _passwordController,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Password'),
          onChanged: (_) => loginStore.clearError(),
        ),
        const SizedBox(height: 4),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Esqueceu a senha?',
              style: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Botão entrar + loading (Observer)
        Center(
          child: SizedBox(
            width: 260,
            height: 46,
            child: Observer(
              builder: (_) => ElevatedButton(
                onPressed: loginStore.isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: loginStore.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Exibe mensagem de erro (Observer)
        Observer(
          builder: (_) {
            if (loginStore.errorMessage.isEmpty) return const SizedBox.shrink();
            return ErrorBox(message: loginStore.errorMessage);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 71, 20, 102),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        47,
                        39,
                        53,
                      ).withOpacity(0.8),
                    ),
                  ),
                  child: _buildLoginForm(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
