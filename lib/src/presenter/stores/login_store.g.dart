// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_LoginStoreBase.hasError',
  )).value;
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??= Computed<bool>(
    () => super.isLoggedIn,
    name: '_LoginStoreBase.isLoggedIn',
  )).value;

  late final _$_userAtom = Atom(
    name: '_LoginStoreBase._user',
    context: context,
  );

  @override
  User get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_LoginStoreBase.errorMessage',
    context: context,
  );

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_LoginStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    '_LoginStoreBase.login',
    context: context,
  );

  @override
  Future<bool> login(String username, String password) {
    return _$loginAsyncAction.run(() => super.login(username, password));
  }

  late final _$_LoginStoreBaseActionController = ActionController(
    name: '_LoginStoreBase',
    context: context,
  );

  @override
  void logout() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
      name: '_LoginStoreBase.logout',
    );
    try {
      return super.logout();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
      name: '_LoginStoreBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
isLoading: ${isLoading},
hasError: ${hasError},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
