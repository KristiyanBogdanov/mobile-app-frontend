import 'package:app/api/auth/auth_service.dart';
import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class AuthRepository {
  AuthLimitsModel? limits;
  final _authService = DependencyInjection.getIt<AuthService>();

  Future<void> fetchLimits() async {
    limits = await _authService.getLimits();
  }

  Future<UserModel> signUp(SignUpDto data) async {
    return await _authService.signUp(data);
  }

  Future<UserModel> signIn(SignInDto data) async {
    return await _authService.signIn(data);
  }

  Future<void> signOut() async {
    return await _authService.signOut();
  }
}
