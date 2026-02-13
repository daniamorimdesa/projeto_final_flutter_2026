// user_store.dart: store de usuário usando MobX
import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart';

import 'package:projeto_final_flutter_2026/src/external/datasources/movies_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  // instância do datasource para reutilização
  final _moviesDs = MoviesDatasource();

  // ---------------- USER ----------------

  @observable
  User _user = User();

  User get user => _user;

  // computed property para verificar se o usuário está autenticado
  @computed
  bool get isAuthenticated => _user.id != 0;

  // ---------------- LISTAS ----------------

  //lista de filmes disponíveis para aluguel
  @observable
  ObservableList<Movie> availableMovies = ObservableList<Movie>();

  //lista de filmes alugados pelo usuário
  @observable
  ObservableList<Movie> rentalMovies = ObservableList<Movie>();

  // ---------------- FLAGS ----------------

  // flags para indicar se uma operação está em andamento
  @observable
  bool isLoadingAvailable = false;

  @observable
  bool isLoadingRental = false;

  @observable
  bool isRenting = false;

  @observable
  bool isWatching = false;

  // ---------------- ERROR ----------------

  @observable
  String errorMessage = "";

  // computed property para verificar se há erro
  @computed
  bool get hasError => errorMessage.isNotEmpty;

  // ---------------- ACTIONS ----------------

  // ação para limpar mensagem de erro
  @action
  void clearError() {
    errorMessage = "";
  }

  // ação para salvar o user no estado
  @action
  void initUser(User user) {
    // atualizar o usuário logado
    _user = user;

    // limpar estado de filmes
    availableMovies.clear();
    rentalMovies.clear();

    // resetar erro e flags de loading
    errorMessage = "";
    isLoadingAvailable = false;
    isLoadingRental = false;
    isRenting = false;
    isWatching = false;
  }

  // ação para buscar filmes disponíveis
  @action
  Future<void> getAvailableMovies() async {
    // ligar loading da aba "available"
    isLoadingAvailable = true;

    try {
      //chamar datasource para buscar filmes disponíveis
      final movies = await _moviesDs.getAvailableMovies();

      // atualizar a lista de filmes disponíveis no estado
      availableMovies
        ..clear()
        ..addAll(
          movies,
        ); // usar clear + addAll para manter a mesma instância da ObservableList

      errorMessage = ""; // limpar erro apenas em caso de sucesso
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("Available movies error: $e");
    } finally {
      isLoadingAvailable = false; // desligar loading da aba "available"
    }
  }

  // ação para buscar filmes alugados pelo usuário
  @action
  Future<void> getRentalMovies() async {
    //verificar se o usuário está autenticado
    if (!isAuthenticated) {
      errorMessage = "Usuário não autenticado";
      return;
    }

    isLoadingRental = true; // ligar loading da aba "rental"

    try {
      errorMessage = ""; // limpar erro antes de começar
      // chamar datasource para buscar filmes alugados pelo usuário
      final movies = await _moviesDs.getMoviesRentalByUser(_user);

      rentalMovies
        ..clear()
        ..addAll(
          movies,
        ); // usar clear + addAll para manter a mesma instância da ObservableList
    } catch (e) {
      errorMessage = e.toString();
      debugPrint("Rental movies error: $e");
    } finally {
      isLoadingRental = false; // desligar loading da aba "rental"
    }
  }

  // ação para alugar um filme para o usuário
  @action
  Future<bool> rentalMovie(Movie movie) async {
    // verificar se o usuário está autenticado
    if (!isAuthenticated) {
      errorMessage = "Usuário não autenticado";
      return false;
    }

    // prevenir aluguel de um filme que já foi alugado
    if (rentalMovies.any((m) => m.id == movie.id)) {
      errorMessage =
          "Este filme já foi alugado. Acesse a aba de filmes alugados para assisti-lo :)";
      return false;
    }

    isRenting = true; // ligar loading da ação de aluguel
    errorMessage = ""; // limpar erro antes de começar

    try {
      // chamar datasource para alugar o filme para o usuário
      final success = await _moviesDs.rentalMovie(_user.id, movie.id);

      if (success) {
        await getRentalMovies(); // atualizar filmes alugados
        await getAvailableMovies(); // atualizar filmes disponíveis (pode ter mudado a disponibilidade)
      }

      return success;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isRenting = false;
    }
  }

  // ação para assistir a um filme alugado
  @action
  Future<bool> watchMovie(Movie movie) async {
    // verificar se o usuário está autenticado
    if (!isAuthenticated) {
      errorMessage = "Usuário não autenticado";
      return false;
    }

    isWatching = true; // ligar loading da ação de assistir
    errorMessage = ""; // limpar erro antes de começar

    try {
      // chamar datasource para assistir ao filme
      final success = await _moviesDs.watchMovie(_user.id, movie.id);

      if (success) {
        await getRentalMovies(); // atualizar filmes alugados
        await getAvailableMovies(); // atualizar filmes disponíveis (pode ter mudado a disponibilidade)
      }

      return success;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isWatching = false; // desligar loading da ação de assistir
    }
  }

  // ação para limpar todos os dados do usuário ao fazer logout
  @action
  void clearDataOnLogout() {
    availableMovies.clear();
    rentalMovies.clear();

    isLoadingAvailable = false;
    isLoadingRental = false;
    isRenting = false;
    isWatching = false;

    errorMessage = "";
  }
}
