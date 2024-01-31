import 'package:app/api/auth/auth_service.dart';
import 'package:app/api/auth/dto/index.dart';
import 'package:app/api/auth/model/index.dart';
import 'package:app/api/user/index.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class AuthRepository {
  AuthLimitsModel? _authLimits;
  final _authService = DependencyInjection.getIt<AuthService>();

  Future<void> fetchLimits() async {
    _authLimits = await _authService.getLimits();
  }

  Future<UserModel> signUp(SignUpDto data) async {
    return await _authService.signUp(data);
  }

  Future<UserModel> signIn(SignInDto data) async {
    return await _authService.signIn(data);
  }

  AuthLimitsModel? get limits => _authLimits;
}
