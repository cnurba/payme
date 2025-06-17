import 'package:get_it/get_it.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/infrastucture/repositories/auth_repository.dart';

// Cоздай метод для инициализации зависимостей
// инициализируй все зависимости в этом методе

// Этот метод должен быть вызван в main перед запуском приложения
// Например, в main.dart перед вызовом runApp

// Создай глобальный экземпляр GetIt
final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepository());
}
