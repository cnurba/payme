import 'package:payme/auth/domain/models/user_model.dart';
import 'package:payme/auth/domain/repositories/i_user_model_cache.dart';

class UserModelCache extends IUserModelCache {
  late UserModel _userModel;

  @override
  void setUserModel(UserModel userModel) {
    _userModel = userModel;
  }

  @override
  UserModel get userModel => _userModel;
}