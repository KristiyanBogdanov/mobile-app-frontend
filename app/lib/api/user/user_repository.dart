import 'package:app/api/location/index.dart';
import 'package:app/api/user/model/index.dart';
import 'package:app/api/user/user_service.dart';
import 'package:app/util/dependency_injection/dependency_injection.dart';

class UserRepository {
  UserModel? userModel;
  final _userService = DependencyInjection.getIt<UserService>();

  Future<void> fetchData() async {
    userModel = await _userService.fetchData();
  }

  Future<LocationModel> addNewLocation(NewLocationDto data) async {
    final location = await _userService.addNewLocation(data);
    userModel!.locations.add(location);

    return location;
  }

  Future<LocationModel> addExistingLocation(String locationUuid) async {
    return await _userService.addExistingLocation(locationUuid);
  }

  Future<void> removeLocation(String locationId) async {
    await _userService.removeLocation(locationId);
    userModel!.locations.removeWhere((location) => location.id == locationId);
  }

  void clearData() {
    userModel = null;
  }
}
