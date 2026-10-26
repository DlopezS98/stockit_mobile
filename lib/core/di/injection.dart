import 'package:get_it/get_it.dart';
import 'package:stockit_mobile/core/network/api_client.dart';
import 'package:stockit_mobile/data/repositories/auth_repository.dart';
import 'package:stockit_mobile/data/repositories/token_repository.dart';
import 'package:stockit_mobile/data/repositories/user_repository.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/providers/user_provider.dart';
import 'package:stockit_mobile/services/auth_service.dart';
import 'package:stockit_mobile/services/user_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(authTokenProvider: () => getIt<TokenRepository>().getToken()),
    dispose: (client) => client.dispose(),
  );

  // Register repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(getIt<ApiClient>()));

  // Register services
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()));
  getIt.registerLazySingleton<UserService>(() => UserService(getIt<UserRepository>()));

  // Register providers
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider(getIt<AuthService>()));
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<UserService>()));
}
