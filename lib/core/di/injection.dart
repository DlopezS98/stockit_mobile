import 'package:get_it/get_it.dart';
import 'package:stockit_mobile/core/network/api_client.dart';
import 'package:stockit_mobile/data/repositories/auth_repository.dart';
import 'package:stockit_mobile/data/repositories/token_repository.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/services/auth_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(), dispose: (client) => client.dispose());

  // Register repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<TokenRepository>(() => TokenRepository());

  // Register services
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()));

  // Register providers
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider(getIt<AuthService>()));
}