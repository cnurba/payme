import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:payme/auth/domain/models/user_model.dart';
import 'package:payme/auth/domain/repositories/i_auth_repository.dart';
import 'package:payme/auth/domain/repositories/i_secure_storage.dart';
import 'package:payme/auth/infrastucture/repositories/auth_repository.dart';
import 'package:payme/core/failure/app_result.dart';

import '../../injection.dart';

/// Provides the AuthController instance

final authRepo = Provider<IAuthRepository>(
      (ref) => AuthRepository(getIt<ISecureStorage>(), getIt<Dio>()),
);

final userProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  final authRepos = ref.watch(authRepo);
  final result = await authRepos.getCurrentUser();
  if(result is ApiResultWithData){
    return result.data;
  }
  return UserModel.empty();
});

