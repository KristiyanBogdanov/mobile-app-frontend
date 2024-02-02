import 'package:app/api/location/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/api/user/user_service.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class UserRepository {
  UserModel? _userModel;
  final _userService = DependencyInjection.getIt<UserService>();

  Future<void> fetchData() async {
    setUser = await _userService.fetchData();
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    return await _userService.addNewLocation(data);
  }

  Future<LocationModel> addExistingLocation(String locationUuid) async {
    return await _userService.addExistingLocation(locationUuid);
  }

  void addLocation(LocationModel locationModel) {
    _userModel!.locations.add(locationModel);
  }

  void clearData() {
    _userModel = null;
  }

  set setUser(UserModel userModel) {
    _userModel = userModel;
  }

  UserModel? get userModel => _userModel;
}
