# Guia de Testes Unitários em Flutter

## 📚 Índice
- [O que são Testes Unitários?](#o-que-são-testes-unitários)
- [Estrutura de um Teste](#estrutura-de-um-teste)
- [Principais Funções](#principais-funções)
- [Matchers Comuns](#matchers-comuns)
- [Como Executar Testes](#como-executar-testes)
- [Boas Práticas](#boas-práticas)
- [Exemplos Práticos](#exemplos-práticos)

---

## O que são Testes Unitários?

Testes unitários são pequenos testes automatizados que verificam se uma parte específica do seu código (geralmente uma função ou classe) funciona conforme esperado. No Flutter, usamos o pacote `flutter_test` para criar esses testes.

**Benefícios:**
- 🐛 Detectam bugs cedo
- 📝 Documentam o comportamento esperado do código
- 🔄 Facilitam refatoração com segurança
- ⚡ Executam rapidamente (sem necessidade de emulador)

---

## Estrutura de um Teste

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Agrupa testes relacionados
  group('Nome do Grupo', () {
    
    // Código executado antes de cada teste
    setUp(() {
      // Inicialização
    });
    
    // Código executado após cada teste
    tearDown(() {
      // Limpeza
    });
    
    // Um teste individual
    test('descrição do que está sendo testado', () {
      // 1. Arrange (Preparar): configurar dados
      final valor = 10;
      
      // 2. Act (Agir): executar a ação
      final resultado = valor * 2;
      
      // 3. Assert (Verificar): checar resultado
      expect(resultado, 20);
    });
  });
}
```

---

## Principais Funções

### `test()`
Define um teste individual. Recebe uma descrição e uma função callback.

```dart
test('soma dois números corretamente', () {
  expect(2 + 2, 4);
});
```

### `group()`
Agrupa testes relacionados para melhor organização.

```dart
group('Calculadora', () {
  test('soma', () { /* ... */ });
  test('subtração', () { /* ... */ });
});
```

### `setUp()`
Executa código antes de cada teste no grupo.

```dart
group('Banco de Dados', () {
  late Database db;
  
  setUp(() {
    db = Database(); // Cria nova instância antes de cada teste
  });
  
  test('insere registro', () { /* ... */ });
});
```

### `tearDown()`
Executa código após cada teste (limpeza).

```dart
tearDown(() {
  db.close(); // Fecha conexão após cada teste
});
```

### `setUpAll()` e `tearDownAll()`
Executam uma vez antes/depois de todos os testes do grupo.

```dart
setUpAll(() {
  // Configuração cara que só precisa rodar uma vez
});
```

---

## Matchers Comuns

Os **matchers** são usados com `expect()` para verificar resultados.

### Igualdade

```dart
expect(resultado, valor);              // Igualdade exata
expect(resultado, equals(valor));      // Mesmo que acima (explícito)
expect(resultado, isNot(valor));       // Diferente
```

### Tipos

```dart
expect(objeto, isA<String>());         // Verifica tipo
expect(lista, isList);                 // É uma lista
expect(mapa, isMap);                   // É um mapa
expect(numero, isInt);                 // É um inteiro
```

### Comparação Numérica

```dart
expect(valor, greaterThan(5));         // Maior que
expect(valor, lessThan(10));           // Menor que
expect(valor, greaterThanOrEqualTo(5)); // Maior ou igual
expect(valor, inRange(1, 10));         // Entre 1 e 10
expect(valor, closeTo(9.99, 0.01));    // Aproximado (importante para doubles!)
```

### Strings

```dart
expect(texto, contains('Flutter'));    // Contém substring
expect(texto, startsWith('Olá'));      // Começa com
expect(texto, endsWith('!'));          // Termina com
expect(texto, matches(r'^\d+$'));      // Corresponde a regex
```

### Listas e Coleções

```dart
expect(lista, isEmpty);                // Lista vazia
expect(lista, isNotEmpty);             // Lista não vazia
expect(lista, hasLength(3));           // Tamanho específico
expect(lista, contains(elemento));     // Contém elemento
expect(lista, containsAll([1, 2, 3])); // Contém todos
expect(lista, everyElement(isPositive)); // Todos satisfazem condição
```

### Exceções

```dart
expect(() => funcao(), throwsException);        // Lança qualquer exceção
expect(() => funcao(), throwsA(isA<TypeError>())); // Lança tipo específico
expect(() => funcao(), returnsNormally);        // Não lança exceção
```

### Valores Especiais

```dart
expect(valor, isNull);                 // É null
expect(valor, isNotNull);              // Não é null
expect(bool, isTrue);                  // É true
expect(bool, isFalse);                 // É false
```

---

## Como Executar Testes

### No Terminal

```bash
# Rodar todos os testes
flutter test

# Rodar arquivo específico
flutter test test/user_movie_adapter_test.dart

# Rodar com cobertura de código
flutter test --coverage

# Rodar em modo watch (re-executa ao salvar)
flutter test --watch

# Rodar testes com nome específico
flutter test --name "serializa"
```

### No VS Code

1. Instale a extensão "Flutter" e "Dart"
2. Abra o arquivo de teste
3. Clique em "Run" ou "Debug" acima de cada `test()` ou `group()`
4. Ou use: `Ctrl+Shift+P` → "Flutter: Run All Tests"

### Atalhos Úteis

- `flutter test --help` - Ver todas as opções
- Adicione `skip: true` para pular um teste temporariamente:
  ```dart
  test('teste em desenvolvimento', () {
    // código
  }, skip: true);
  ```

---

## Boas Práticas

### 1. Nomes Descritivos
❌ **Ruim:**
```dart
test('teste 1', () { /* ... */ });
```

✅ **Bom:**
```dart
test('deve retornar lista vazia quando não houver filmes', () { /* ... */ });
```

### 2. Um Conceito por Teste
❌ **Ruim:**
```dart
test('testa tudo', () {
  expect(adapter.serialize(), isNotNull);
  expect(adapter.deserialize(), isNotNull);
  expect(adapter.validate(), isTrue);
});
```

✅ **Bom:**
```dart
test('serializa objeto corretamente', () {
  expect(adapter.serialize(), isNotNull);
});

test('desserializa objeto corretamente', () {
  expect(adapter.deserialize(), isNotNull);
});
```

### 3. Cuidado com Comparação de Doubles
❌ **Ruim:**
```dart
expect(movie.value, 9.99); // Pode falhar por precisão de ponto flutuante
```

✅ **Bom:**
```dart
expect(movie.value, closeTo(9.99, 0.01)); // Tolera pequenas diferenças
```

### 4. Use AAA Pattern (Arrange-Act-Assert)
```dart
test('calcula desconto corretamente', () {
  // Arrange: preparar dados
  final preco = 100.0;
  final desconto = 0.1;
  
  // Act: executar ação
  final resultado = calcularPrecoComDesconto(preco, desconto);
  
  // Assert: verificar resultado
  expect(resultado, closeTo(90.0, 0.01));
});
```

### 5. Testes Independentes
Cada teste deve funcionar sozinho, sem depender da ordem de execução.

### 6. Use `setUp()` para Código Repetitivo
```dart
group('UserAdapter', () {
  late User user;
  
  setUp(() {
    user = User()
      ..id = 1
      ..username = 'teste';
  });
  
  test('valida username', () {
    expect(user.username, 'teste');
  });
});
```

---

## Exemplos Práticos

### Exemplo 1: Teste de Serialização (do projeto)

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';

void main() {
  group('UserAdapter', () {
    test('serializa e desserializa User corretamente', () {
      // Arrange: criar objeto User
      final user = User()
        ..id = 1
        ..username = 'usuario'
        ..password = 'senha';

      // Act: serializar e desserializar
      final bytes = UserAdapter.encodeProto(user);
      final userDecoded = UserAdapter.decodeProto(bytes);

      // Assert: verificar se os dados foram preservados
      expect(userDecoded.id, user.id);
      expect(userDecoded.username, user.username);
      expect(userDecoded.password, user.password);
    });
  });
}
```

### Exemplo 2: Teste de Lista

```dart
test('filtra filmes por ano', () {
  // Arrange
  final filmes = [
    Movie()..title = 'Filme A'..year = '2023',
    Movie()..title = 'Filme B'..year = '2024',
    Movie()..title = 'Filme C'..year = '2023',
  ];
  
  // Act
  final filmesDe2023 = filmes.where((f) => f.year == '2023').toList();
  
  // Assert
  expect(filmesDe2023, hasLength(2));
  expect(filmesDe2023[0].title, 'Filme A');
  expect(filmesDe2023[1].title, 'Filme C');
});
```

### Exemplo 3: Teste de Exceção

```dart
test('lança exceção quando ID é inválido', () {
  // Arrange
  final invalidId = -1;
  
  // Act & Assert
  expect(
    () => buscarFilmePorId(invalidId),
    throwsA(isA<ArgumentError>()),
  );
});
```

### Exemplo 4: Teste Assíncrono

```dart
test('carrega filmes da API', () async {
  // Arrange
  final api = MovieAPI();
  
  // Act
  final filmes = await api.fetchMovies();
  
  // Assert
  expect(filmes, isNotEmpty);
  expect(filmes.first, isA<Movie>());
});
```

### Exemplo 5: Mock (com Mockito)

```dart
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([MovieRepository])
void main() {
  test('busca filme no repositório', () async {
    // Arrange
    final mockRepo = MockMovieRepository();
    final filme = Movie()..id = 1..title = 'Teste';
    
    when(mockRepo.getMovie(1)).thenAnswer((_) async => filme);
    
    // Act
    final resultado = await mockRepo.getMovie(1);
    
    // Assert
    expect(resultado.title, 'Teste');
    verify(mockRepo.getMovie(1)).called(1);
  });
}
```

---

## 📖 Recursos Adicionais

- [Documentação Oficial - Flutter Testing](https://docs.flutter.dev/testing)
- [Pacote flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
- [Mockito para Dart](https://pub.dev/packages/mockito)
- [Testing Best Practices](https://docs.flutter.dev/cookbook/testing)

---

## 🎯 Resumo Rápido

```dart
// Estrutura básica
test('descrição', () {
  // Arrange
  final dado = preparaDado();
  
  // Act
  final resultado = executa(dado);
  
  // Assert
  expect(resultado, esperado);
});

// Matchers mais usados
expect(valor, equals(10));
expect(valor, closeTo(10.0, 0.01));
expect(lista, hasLength(5));
expect(texto, contains('palavra'));
expect(() => funcao(), throwsException);
```

**Dica Final:** Escreva testes que sejam fáceis de entender e manter. Testes são documentação viva do seu código! 🚀
