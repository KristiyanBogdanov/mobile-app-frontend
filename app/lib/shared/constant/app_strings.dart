class AppStrings {
  AppStrings._();

  static const String appName = 'Diploma project';

  static const String signInPageTitle = 'Sign in';
  static const String signInButton = 'Sign in';
  static const String createAccountButton = 'Create account';

  static const String signUpPageTitle = 'Sign up';
  static const String signUpButton = 'Sign up';

  static const String usernameLabel = 'Username';
  static const String usernameHint = 'Enter your username';
  static const String emailLabel = 'Email';
  static const String emailHint = 'Enter your email';
  static const String passwordLabel = 'Password';
  static const String passwordHint = 'Enter your password';
  static const String confirmPasswordLabel = 'Confirm password';
  static const String confirmPasswordHint = 'Confirm your password';
  static const String requiredUsername = 'Username is required';
  static const String requiredEmail = 'Email is required';
  static const String invalidEmailFormat = 'Email format is invalid';
  static const String invalidEmail = 'Email is invalid';
  static const String requiredPassword = 'Password is required';
  static const String invalidPassword = 'Password is invalid';
  static const String invalidConfirmPassword = 'Passwords do not match';
  static const String tooShortUsername = 'Username is too short';
  static const String weakPassword = 'Password is too weak';
  static const String emailAlreadyUsed = 'Email is already used';
  static const String signInBadRequest = 'Invalid sign in data';
  static const String signUpBadRequest = 'Invalid sign up data';

  static const String unauthorizedError = 'Unauthorized';
  static const String anauthorizedDialogDescription = 'You are not authorized. Please sign in or sign up';
  static const String anauthorizedDialogButton = 'OK';
  static const String unknownError = 'Unknown error';
  static const String unknownErrorDialogDescription = 'Something went wrong. Please try again later';
  static const String unknownErrorDialogButton = 'OK';

  static const String locationsPageNavBarLabel = 'Locations';
  static const String assistantPageNavBarLabel = 'Assistant';
  static const String marketplacePageNavBarLabel = 'Marketplace';

  static const String locationsPageTitle = 'Locations';
  static const String assistantPageTitle = 'Assistant';
  static const String marketplacePageTitle = 'Marketplace';

  static const String stSerialNumberAlreadyUsedError = 'Some of the solar trackers are already used';
  static const String locationAlreadyAddedError = 'Location is already added';
  static const String addNewLocationBadRequest = 'Invalid add new location data';
  static const String addExistingLocationBadRequest = 'Invalid add existing location data'; // TODO: I think this string is meaningless

  static const String addNewLocationPageTitle = 'Add new location';
  static const String locationNameLabel = 'Location name';
  static const String locationCoordinatesLabel = 'Location coordinates';
  static const String capacityLabel = 'Capacity (kW)';
  static const String solarTrackersLabel = 'Solar trackers';
  static const String weatherStationLabel = 'Weather station';
  static const String serialNumberLabel = 'Serial number';
  static const String inputFieldHint = 'Type here...';
  static const String addDeviceButton = 'Add device';
  static const String cancelButton = 'Cancel';
  static const String addSolarTrackerButton = 'Add Solar Tracker';
  static const String addWeatherStationButton = 'Add Weather Station';
  static const String addLocationButton = 'Add location';

  static const String requiredLocationName = 'Location name is required';
  static const String requiredLocationCoordinates = 'Location coordinates are required';
  static const String requiredCapacity = 'Location capacity is required';
  static const String requiredSeialNumber = 'Serial number is required';
  static const String stSerialNumberAlreadyAdded = 'You have already added this solar tracker';
  static const String invalidSTSerialNumber = 'Invalid solar tracker serial number';
  static const String locationWithThisSTSerialNumberAlreadyAdded = 'You have already added location with this solar tracker';
  static const String locationWithThisSTSerialNumberAlreadExists = 'Location with this solar tracker already exists';
  static const String invalidWSSerialNumber = 'Invalid weather station serial number';
  static const String invalidLocationNameLength = 'Location name length is out of range';
  static const String invalidCapacity = 'Capacity must be positive integer';
  static const String invalidSTArraySize = 'Solar trackers array must contain at least one serial number';

  static const String weatherStation = 'Weather station';
  static const String cctv = 'CCTV';
  static const String capacity = 'Capacity';
  static const String kwh = 'kWh';
  static String installedSolarTrackers(int count) => count == 1 ? 'Solar tracker' : 'Solar trackers';
  static const String installed = 'installed';
  static String sharedWith(int count) => count == 1 ? 'Shared with $count person' : 'Shared with $count people';
  static const String notShared = 'Not shared with anyone';

  static const String addNewLocationButton = 'new';

  static const String scanQRCodeTitle = 'Scan QR Code';
  static const String scanQRCodeDescription = 'Align the QR Code within the frame';

  static const String noLocationsTitle = 'No locations yet';
  static const String noLocationsDescription = 'Add a new location from the button above.';
}
