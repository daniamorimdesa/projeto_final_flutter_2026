// HomePageMobx com TabBar: available movies e movies rental by user
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:projeto_final_flutter_2026/src/presenter/pages/components/available_movies_tab.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/rental_movies_tab.dart';

import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // chama depois do primeiro frame para garantir context ok
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userStore = context.read<UserStore>();
      userStore.getAvailableMovies();
      userStore.getRentalMovies();
    });
  }

  void _handleLogout(BuildContext context) {
    // limpa login (MobX)
    context.read<LoginStore>().logout();

    // limpa dados do usuário (MobX)
    context.read<UserStore>().clearDataOnLogout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = context.read<UserStore>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: const Color.fromARGB(255, 23, 4, 65),
          foregroundColor: const Color.fromARGB(255, 204, 187, 248),
          elevation: 0,
          titleSpacing: 16,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color.fromARGB(255, 249, 247, 252),
                  child: Icon(
                    Icons.person_rounded,
                    color: Color.fromARGB(255, 204, 187, 248),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Observer(
                    builder: (_) => Text(
                      userStore.user.username,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 204, 187, 248),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IconButton(
                iconSize: 22,
                icon: const Icon(Icons.logout_rounded),
                onPressed: () => _handleLogout(context),
                tooltip: 'Logout',
              ),
            ),
            const SizedBox(width: 16),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Color.fromARGB(179, 255, 255, 255),
              labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              tabs: [
                Tab(icon: Icon(Icons.movie_filter), text: 'Available movies'),
                Tab(
                  icon: Icon(Icons.recent_actors_outlined),
                  text: 'Movies rental',
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 21, 1, 32),
          child: const TabBarView(
            children: [AvailableMoviesTab(), RentalMoviesTab()],
          ),
        ),
      ),
    );
  }
}
