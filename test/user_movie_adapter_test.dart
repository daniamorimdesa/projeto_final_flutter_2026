// user_movie_adapter_test.dart: Testes para UserAdapter e MovieAdapter

import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart'; // Importa o pacote de teste do Flutter
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/movie_adapter.dart';

void main() {
  group('UserAdapter', () {
    test('serializa e desserializa User', () {
      // Teste para UserAdapter

      // Cria uma instância de User
      final user = User()
        ..id = 1
        ..username = 'usuario'
        ..password = 'senha';

      final bytes = UserAdapter.encodeProto(
        user,
      ); // Serializa o User para bytes
      final userDecoded = UserAdapter.decodeProto(
        bytes,
      ); // Desserializa os bytes de volta para User

      // Verifica se os campos são iguais
      expect(userDecoded.id, user.id);
      expect(userDecoded.username, user.username);
      expect(userDecoded.password, user.password);
    });
  });

  group('MovieAdapter', () {
    test('serializa e desserializa Movie', () {
      // Teste para MovieAdapter
      // Cria uma instância de Movie
      final movie = Movie()
        ..id = 10
        ..title = 'Filme'
        ..cover = Uint8List.fromList([1, 2, 3])
        ..value = 9.99
        ..year = '2023'
        ..director = 'Diretor'
        ..sinopse = 'Sinopse';

      final bytes = MovieAdapter.encodeProto(
        movie,
      ); // Serializa o Movie para bytes
      final movieDecoded = MovieAdapter.decodeProto(
        bytes,
      ); // Desserializa os bytes de volta para Movie

      // Verifica se os campos são iguais
      expect(movieDecoded.id, movie.id);
      expect(movieDecoded.title, movie.title);
      expect(movieDecoded.cover, movie.cover);
      // expect(movieDecoded.value, movie.value); dá erro de precisão com double
      expect(
        movieDecoded.value,
        closeTo(movie.value, 1e-6),
      ); // Usando closeTo para comparação de double
      expect(movieDecoded.year, movie.year);
      expect(movieDecoded.director, movie.director);
      expect(movieDecoded.sinopse, movie.sinopse);
    });

    test('serializa e desserializa lista de Movie', () {
      // Teste para lista de Movie
      // Cria uma lista de Movie
      final movie1 = Movie()
        ..id = 1
        ..title = 'A';
      final movie2 = Movie()
        ..id = 2
        ..title = 'B';
      final movies = Movies()
        ..movies.addAll([movie1, movie2]); // Adiciona os filmes à lista

      final bytes = movies
          .writeToBuffer(); // Serializa a lista de Movie para bytes
      final moviesDecoded = MovieAdapter.decodeProtoList(
        bytes,
      ); // Desserializa os bytes de volta para lista de Movie

      // Verifica se os filmes são iguais
      expect(moviesDecoded.length, 2);
      expect(moviesDecoded[0].id, movie1.id);
      expect(moviesDecoded[1].title, movie2.title);
    });
  });
}
