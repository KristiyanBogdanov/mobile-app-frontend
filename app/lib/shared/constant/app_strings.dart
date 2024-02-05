class AppStrings {
  AppStrings._();

  static const String appTitle = 'Diploma project';
  static const String appName = 'PURPLE';
  static const String appSlogan = 'Monitor your solar trackers systems in real time using our app';

  static const String signInPageTitle = 'Welcome back';
  static const String signInSubtitle = 'Sign in to continue';
  static const String signInButton = 'Sign in';
  static const String signUpPageTitle = 'Create an account';
  static const String signUpSubtitle = 'Sign up to continue';
  static const String signUpButton = 'Sign up';
  static const String createAccountButton = 'Register';

  static const String usernameHint = 'Username';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String confirmPasswordHint = 'Confirm password';
  static const String requiredUsername = 'Username is required';
  static const String requiredEmail = 'Email is required';
  static const String invalidEmailFormat = 'Email format is invalid';
  static const String requiredPassword = 'Password is required';
  static String invalidPasswordLength(int minLength, int maxLength) =>
      'Password length must be between $minLength and $maxLength characters';
  static String invalidPassword(int minNumbers, int minLowercase, int minUppercase) =>
      'Password must contain at least $minNumbers ${minNumbers == 1 ? 'number' : 'numbers'}, $minLowercase lowercase and $minUppercase uppercase letters';
  static const String invalidConfirmPassword = 'Passwords do not match';
  static const String wrongCredentialsError = 'Password or email is incorrect';
  static String invalidUsernameLength(int minLength, int maxLength) =>
      'Username length must be between $minLength and $maxLength characters';
  static const String emailAlreadyUsedError = 'Email is already used';

  static const String badRequestError = 'Invalid data. Please check your input.';
  static const String unauthorizedError = 'Unauthorized';
  static const String anauthorizedDialogDescription = 'You are not authorized. Please sign in or sign up';
  static const String anauthorizedDialogButton = 'OK';
  static const String unknownError = 'Unknown error. You can try again later';
  static const String serverError = 'Server error. Please try again later';

  static const String locationsPageNavBarLabel = 'Locations';
  static const String notificationsPageNavBarLabel = 'Notifications';
  static const String marketplacePageNavBarLabel = 'Marketplace';
  static const String profilePageNavBarLabel = 'Profile';

  static const String locationsPageTitle = 'Locations';
  static const String notificationsPageTitle = 'Notifications';
  static const String marketplacePageTitle = 'Marketplace';

  static const String stSerialNumberAlreadyUsedError = 'Some of the solar trackers are already used';
  static const String locationAlreadyAddedError = 'Location is already added';
  static const String addNewLocationBadRequest = 'Invalid add new location data';
  static const String addExistingLocationBadRequest =
      'Invalid add existing location data'; // TODO: I think this string is meaningless

  static const String addNewLocationPageTitle = 'Add new location';
  static const String locationNameSectionTitle = 'Location name';
  static const String locationCoordinatesSectionTitle = 'Location coordinates';
  static const String solarTrackersSectionTitle = 'Solar trackers';
  static const String weatherStationSectionTitle = 'Weather station';
  static const String serialNumberLabel = 'Serial number';
  static const String inputFieldHint = 'Type here...';
  static const String addDeviceButton = 'Add device';
  static const String cancelButton = 'Cancel';
  static const String addLocationButton = 'Add location';

  static const String requiredLocationName = 'Location name is required';
  static const String requiredLocationCoordinates = 'Location coordinates are required';
  static const String requiredCapacity = 'Location capacity is required';
  static const String requiredSeialNumber = 'Serial number is required';
  static const String stSerialNumberAlreadyAdded = 'You have already added this solar tracker';
  static const String invalidSTSerialNumber = 'Invalid solar tracker serial number';
  static const String locationWithThisSTSerialNumberAlreadyAdded =
      'You have already added location with this solar tracker';
  static const String locationWithThisSTSerialNumberAlreadExists = 'Location with this solar tracker already exists';
  static const String invalidWSSerialNumber = 'Invalid weather station serial number';
  static String invalidLocationNameLength(int minLength, int maxLength) =>
      'Location name length must be between $minLength and $maxLength characters';
  static const String invalidCapacity = 'Capacity must be positive integer';
  static const String invalidSTArraySize = 'Solar trackers array must contain at least one serial number';

  static const String weatherStation = 'Weather station';
  static const String cctv = 'CCTV';
  static const String capacity = 'Capacity';
  static const String slots = 'slots';
  static String installedSolarTrackers(int count) => count == 1 ? 'Solar tracker' : 'Solar trackers';
  static const String installed = 'installed';
  static String sharedWith(int count) => count == 1 ? 'Shared with $count person' : 'Shared with $count people';
  static const String notShared = 'Not shared with anyone';

  static const String addNewLocationButton = 'new';

  static const String scanQRCodeTitle = 'Scan QR Code';
  static const String scanQRCodeDescription = 'Align the QR Code within the frame';

  static const String noLocationsTitle = 'No locations yet';
  static const String noLocationsDescription = 'Add a new location from the button above.';
  static const String noNotificationsTitle = 'No notifications yet';
  static const String noNotificationsDescription = 'You will see notifications here.';
  static String daysAgo(int days) => '${days} days';
  static String hoursAgo(int hours) => '${hours} hours';
  static String minutesAgo(int minutes) => '${minutes} min';
  static const String justNow = 'Just now';
  static const String deviceState = 'Device state';
  static const String inactiveDevice = 'Iinactive device';
  static const String information = 'No action required';
  static const String warning = 'You should check your device';
  static const String critical = 'We recommend you to check your device immediately and contact support';

  static const String overviewTabTitle = 'Overview';
  static const String weatherStationTabTitle = 'Weather station';
  static const String cctvTabTitle = 'CCTV';
  static const String na = 'N/A';
  static const String lastUpdate = 'Last update';
  static const String temperature = 'Temperature';
  static const String windSpeed = 'Wind speed';
  static const String windDirection = 'Wind direction';
  static String temperatureValue(num temperature, {bool merge = false}) => merge ? '$temperature°C' : '$temperature °C';
  static String windSpeedValue(num windSpeed, {bool merge = false}) => merge ? '${windSpeed}m/s' : '${windSpeed} m/s';
  static String irradianceValue(num irradiance) => '${irradiance}W/m²';
  static const String sensorsSectionTitle = 'Sensors';
  static const String coordinatesSectionTitle = 'Coordinates';
  static const String active = 'Active';
  static const String inactive = 'Inactive';
  static const String anemometer = 'Anemometer';
  static const String temperatureSensor = 'Temp sensor';
  static String installedOn(String date) => 'Installed on $date';
  static const String accelerometer = 'Accelerometer';
  static const String irradianceSensor = 'Irradiance sensor';
  static const String azimuthMotor = 'Azimuth motor';
  static const String elevationMotor = 'Elevation motor';
  static String hours(int hours) => '${hours}h';
  static const String noData = 'No data available at the moment.';
  static const String averageIrradiance = 'Average irradiance';
  static const String averageTemperature = 'Average temperature';
  static const String averageWindSpeed = 'Average wind speed';
  static String deviation(num deviation) => deviation > 0 ? '+$deviation°σ' : '$deviation°σ';
  static const String azimuthIndicatorLabel = 'Azimuth:';
  static const String elevationIndicatorLabel = 'Elevation:';
  static const String noWeatherStationInstalledTitle = 'No weather station installed';
  static const String noWeatherStationInstalledDescription = 'Only the owner of the location can install one.';
  static const String addWeatherStationButtonLabel = 'Add weather station';
  static const String deleteLocation = 'Delete location';
  static const String deleteWeatherStation = 'Delete weather station';

  static const String sharedWithSectionTitle = 'Shared with';

  static const String futureDevelopmentLabel = 'This feature is for future development.';
}
