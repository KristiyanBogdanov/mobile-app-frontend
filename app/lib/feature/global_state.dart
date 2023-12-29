import 'package:app/api/user/index.dart';

class GlobalState {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  void setUser(UserModel userModel) {
    _userModel = userModel;
  }
}
