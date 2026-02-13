// login_store.dart: gerencia o estado de login do usuário usando MobX
import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart'; // debugPrint
import 'package:projeto_final_flutter_2026/src/external/datasources/user_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

// para gerar esse aquivo, rode:dart run build_runner build --delete-conflicting-outputs
// ou dart run build_runner watch --delete-conflicting-outputs
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  // variável privada para armazenar o usuário
  @observable
  User _user = User();

  // getter para acessar o usuário
  User get user => _user;

  // variável para armazenar mensagens de erro
  @observable
  String errorMessage = "";

  // computed property para verificar se há erro
  @computed
  bool get hasError => errorMessage.isNotEmpty;

  // computed property para verificar se o usuário está logado
  @computed
  bool get isLoggedIn => _user.username.isNotEmpty;

  // isLoading para indicar que o login está em andamento
  @observable
  bool isLoading = false;

  // método para realizar o login do usuário
  @action
  Future<bool> login(String username, String password) async {
    // prevenir múltiplos logins simultâneos
    if (isLoading) return false;

    // ligar loading
    isLoading = true;
    // limpar erro antes de tentar logar
    errorMessage = "";

    // cria o objeto User para a requisição
    final requestUser = User()
      ..username = username
      ..password = password;

    try {
      // busca informações do usuário
      final userResponse = await UserDatasource().login(requestUser);

      // atualiza o estado com o usuário logado
      _user = userResponse;

      // limpa a mensagem de erro quando o login é bem-sucedido
      errorMessage = "";
      return true;
    } catch (e) {
      debugPrint("Login error: $e");

      // trata mensagens de erro específicas
      final msg = e.toString().toLowerCase();

      if (msg.contains("credenciais inválidas") || msg.contains("401")) {
        errorMessage = "Usuário ou senha inválidos. Tente novamente.";
      } else if (msg.contains("conectar ao servidor") ||
          msg.contains("socket")) {
        errorMessage =
            "Não foi possível conectar ao servidor. Verifique se a API está rodando.";
      } else {
        errorMessage = "Ocorreu um erro ao tentar entrar. Tente novamente.";
      }
      return false;
    } finally {
      isLoading = false; // desligar loading
    }
  }

  // método para limpar o estado do usuário
  @action
  void logout() {
    _user = User();
    errorMessage = "";
  }

  // método para limpar a mensagem de erro
  @action
  void clearError() {
    errorMessage = "";
  }
}
