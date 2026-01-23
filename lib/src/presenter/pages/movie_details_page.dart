// movie_details_page.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>();
    final coverBytes = Uint8List.fromList(movie.cover);

    const pageBg1 = Color(0xFF14001F);
    const pageBg2 = Color(0xFF06000D);

    // dentro do build, no lugar do Center/ConstrainedBox/Container
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF14001F), Color(0xFF06000D)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 56),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // poster
              SizedBox(
                width: 520,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: coverBytes.isNotEmpty
                        ? Image.memory(coverBytes, fit: BoxFit.cover)
                        : _fallback(),
                  ),
                ),
              ),

              const SizedBox(width: 72),

              // infos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.6,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 18),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Text(
                        movie.sinopse,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          height: 1.65,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // infos uma embaixo da outra
                    _InfoLine(label: "DIRECTOR", value: movie.director),
                    const SizedBox(height: 10),
                    _InfoLine(label: "YEAR", value: movie.year),
                    const SizedBox(height: 10),
                    _InfoLine(
                      label: "PRICE",
                      value: "R\$ ${movie.value.toStringAsFixed(2)}",
                    ),

                    const SizedBox(height: 38),

                    // botões (como no mock: grandes e centralizados na área)
                    Row(
                      children: [
                        SizedBox(
                          width: 360,
                          height: 60,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white70,
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.35),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: const Text("cancel"),
                          ),
                        ),
                        const SizedBox(width: 26),
                        SizedBox(
                          width: 360,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: store.isRenting
                                ? null
                                : () async {
                                    final ok = await context
                                        .read<UserStore>()
                                        .rentalMovie(movie);
                                    if (!context.mounted) return;

                                    if (ok) {
                                      Navigator.pop(context);
                                    } else if (context
                                        .read<UserStore>()
                                        .errorMessage
                                        .isNotEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            context
                                                .read<UserStore>()
                                                .errorMessage,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF4B0377),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: store.isRenting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text("rental"),
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
    );
  }

  Widget _fallback() => Container(
    color: Colors.white.withOpacity(0.08),
    alignment: Alignment.center,
    child: const Icon(
      Icons.local_movies_outlined,
      size: 64,
      color: Color.fromARGB(255, 217, 177, 222),
    ),
  );
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.45),
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }
}
