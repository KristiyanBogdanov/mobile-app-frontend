import 'package:app/api/auth/auth_service.dart';
import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/dependency_injection/index.dart';

class AuthRepository {
  final _authService = DependencyInjection.getIt<AuthService>();

  Future<UserModel> signUp(SignUpDto data) async {
    return await _authService.signUp(data);
  }

  Future<UserModel> signIn(SignInDto data) async {
    return await _authService.signIn(data);
  }
}
