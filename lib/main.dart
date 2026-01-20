import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => LoginStore())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // testar o encode/decode do protobuf
    // testeProto();
  }

  @override
  void dispose() {
    super.dispose(); // liberar recursos
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


  // void testeProto() {
  //   try {
  //     // criar um usuário
  //     final user = User()
  //       ..name = "Daniela"
  //       ..email = "dani@email.com"
  //       ..address = "Rua 1, do lado da rua 2";

  //     // testar a serialização - (User -> Uint8List)
  //     final encoded = UserAdapter.encodeProto(user);
  //     debugPrint("Encoded: $encoded. Tamanho: ${encoded.length}");

  //     // testar a desserialização - (Uint8List -> User)
  //     final decoded = UserAdapter.decodeProto(encoded);
  //     debugPrint(
  //       "Decoded: \nname: ${decoded.name} \nemail: ${decoded.email} \naddress: ${decoded.address}",
  //     );
  //   } catch (e, st) {
  //     debugPrint('Falha no autoteste do proto: $e');
  //     debugPrint(st.toString());
  //   }
  // }