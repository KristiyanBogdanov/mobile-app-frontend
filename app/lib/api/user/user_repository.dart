import 'package:app/api/location/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/api/user/user_service.dart';
import 'package:app/util/dependency_injection/index.dart';

class UserRepository {
  final _userService = DependencyInjection.getIt<UserService>();

  Future<UserModel> fetchData() async {
    return await _userService.fetchData();
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    return await _userService.addNewLocation(data);
  }

  Future<LocationModel> addExistingLocation(String locationUuid) async {
    return await _userService.addExistingLocation(locationUuid);
  }
}