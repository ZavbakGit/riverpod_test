import 'dart:async';

import 'package:app_riverpod_test/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(ref.read)..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  void appStarted() async {
    final user = _read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      await _read(authRepositoryProvider).signInAnonymously();
    }
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
