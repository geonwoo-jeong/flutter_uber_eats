import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_uber_eats/common/constraints/data.dart';
import 'package:flutter_uber_eats/common/secure_storage/secure_storage.dart';
import 'package:flutter_uber_eats/users/models/user_model.dart';
import 'package:flutter_uber_eats/users/repositories/auth_repository.dart';
import 'package:flutter_uber_eats/users/repositories/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      state = UserModelError(message: '???????????? ??????????????????');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }
}
