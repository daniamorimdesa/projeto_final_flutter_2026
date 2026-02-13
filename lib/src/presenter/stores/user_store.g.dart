// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated => (_$isAuthenticatedComputed ??= Computed<bool>(
    () => super.isAuthenticated,
    name: '_UserStoreBase.isAuthenticated',
  )).value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_UserStoreBase.hasError',
  )).value;

  late final _$_userAtom = Atom(name: '_UserStoreBase._user', context: context);

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

  late final _$availableMoviesAtom = Atom(
    name: '_UserStoreBase.availableMovies',
    context: context,
  );

  @override
  ObservableList<Movie> get availableMovies {
    _$availableMoviesAtom.reportRead();
    return super.availableMovies;
  }

  @override
  set availableMovies(ObservableList<Movie> value) {
    _$availableMoviesAtom.reportWrite(value, super.availableMovies, () {
      super.availableMovies = value;
    });
  }

  late final _$rentalMoviesAtom = Atom(
    name: '_UserStoreBase.rentalMovies',
    context: context,
  );

  @override
  ObservableList<Movie> get rentalMovies {
    _$rentalMoviesAtom.reportRead();
    return super.rentalMovies;
  }

  @override
  set rentalMovies(ObservableList<Movie> value) {
    _$rentalMoviesAtom.reportWrite(value, super.rentalMovies, () {
      super.rentalMovies = value;
    });
  }

  late final _$isLoadingAvailableAtom = Atom(
    name: '_UserStoreBase.isLoadingAvailable',
    context: context,
  );

  @override
  bool get isLoadingAvailable {
    _$isLoadingAvailableAtom.reportRead();
    return super.isLoadingAvailable;
  }

  @override
  set isLoadingAvailable(bool value) {
    _$isLoadingAvailableAtom.reportWrite(value, super.isLoadingAvailable, () {
      super.isLoadingAvailable = value;
    });
  }

  late final _$isLoadingRentalAtom = Atom(
    name: '_UserStoreBase.isLoadingRental',
    context: context,
  );

  @override
  bool get isLoadingRental {
    _$isLoadingRentalAtom.reportRead();
    return super.isLoadingRental;
  }

  @override
  set isLoadingRental(bool value) {
    _$isLoadingRentalAtom.reportWrite(value, super.isLoadingRental, () {
      super.isLoadingRental = value;
    });
  }

  late final _$isRentingAtom = Atom(
    name: '_UserStoreBase.isRenting',
    context: context,
  );

  @override
  bool get isRenting {
    _$isRentingAtom.reportRead();
    return super.isRenting;
  }

  @override
  set isRenting(bool value) {
    _$isRentingAtom.reportWrite(value, super.isRenting, () {
      super.isRenting = value;
    });
  }

  late final _$isWatchingAtom = Atom(
    name: '_UserStoreBase.isWatching',
    context: context,
  );

  @override
  bool get isWatching {
    _$isWatchingAtom.reportRead();
    return super.isWatching;
  }

  @override
  set isWatching(bool value) {
    _$isWatchingAtom.reportWrite(value, super.isWatching, () {
      super.isWatching = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_UserStoreBase.errorMessage',
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

  late final _$getAvailableMoviesAsyncAction = AsyncAction(
    '_UserStoreBase.getAvailableMovies',
    context: context,
  );

  @override
  Future<void> getAvailableMovies() {
    return _$getAvailableMoviesAsyncAction.run(
      () => super.getAvailableMovies(),
    );
  }

  late final _$getRentalMoviesAsyncAction = AsyncAction(
    '_UserStoreBase.getRentalMovies',
    context: context,
  );

  @override
  Future<void> getRentalMovies() {
    return _$getRentalMoviesAsyncAction.run(() => super.getRentalMovies());
  }

  late final _$rentalMovieAsyncAction = AsyncAction(
    '_UserStoreBase.rentalMovie',
    context: context,
  );

  @override
  Future<bool> rentalMovie(Movie movie) {
    return _$rentalMovieAsyncAction.run(() => super.rentalMovie(movie));
  }

  late final _$watchMovieAsyncAction = AsyncAction(
    '_UserStoreBase.watchMovie',
    context: context,
  );

  @override
  Future<bool> watchMovie(Movie movie) {
    return _$watchMovieAsyncAction.run(() => super.watchMovie(movie));
  }

  late final _$_UserStoreBaseActionController = ActionController(
    name: '_UserStoreBase',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
      name: '_UserStoreBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initUser(User user) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
      name: '_UserStoreBase.initUser',
    );
    try {
      return super.initUser(user);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearDataOnLogout() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
      name: '_UserStoreBase.clearDataOnLogout',
    );
    try {
      return super.clearDataOnLogout();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
availableMovies: ${availableMovies},
rentalMovies: ${rentalMovies},
isLoadingAvailable: ${isLoadingAvailable},
isLoadingRental: ${isLoadingRental},
isRenting: ${isRenting},
isWatching: ${isWatching},
errorMessage: ${errorMessage},
isAuthenticated: ${isAuthenticated},
hasError: ${hasError}
    ''';
  }
}
