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
  static const String signOutButton = 'Sign out';

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
  static const String unauthorizedDialogTitle = 'Unauthorized';
  static const String unauthorizedDialogDescription = 'You are not authorized. Please sign in or sign up';
  static const String unauthorizedDialogButton = 'Ok';
  static const String unknownError = 'Unknown error. You can try again later';
  static const String serverError = 'Server error. Please try again later';
  static const String firebaseError = 'Firebase error. Please try again later';

  static const String locationsPageNavBarLabel = 'Locations';
  static const String notificationsPageNavBarLabel = 'Notifications';
  static const String marketplacePageNavBarLabel = 'Marketplace';
  static const String profilePageNavBarLabel = 'Profile';

  static const String locationsPageTitle = 'Locations';
  static const String notificationsPageTitle = 'Notifications';
  static const String marketplacePageTitle = 'Marketplace';
  static const String profilePageTitle = 'Profile';

  static const String stSerialNumberAlreadyUsedError = 'Some of the solar trackers are already used';
  static const String locationAlreadyAddedError = 'Location is already added';
  static const String addNewLocationBadRequest = 'Invalid add new location data';

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
  static const String add = 'add';
  static const String invite = 'invite';

  static const String scanQRCodeTitle = 'Scan QR Code';
  static const String scanQRCodeDescription = 'Align the QR Code within the frame';

  static const String noLocationsTitle = 'No locations yet';
  static const String noLocationsDescription = 'Add a new location from the button above.';
  static const String noNotificationsTitle = 'No notifications yet';
  static const String noNotificationsDescription = 'You will see notifications here.';
  static String daysAgo(int days) => days == 1 ? '1 day' : '$days days';
  static String hoursAgo(int hours) => hours == 1 ? '1 hour' : '$hours hours';
  static String minutesAgo(int minutes) => minutes == 1 ? '1 minute' : '$minutes minutes';
  static const String justNow = 'Just now';
  static const String deviceState = 'Device state';
  static const String inactiveDevice = 'Iinactive device';
  static const String information = 'Information';
  static const String warning = 'Warning';
  static const String critical = 'Critical';

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
  static const String notSharedWithAnyoneYet = 'Not shared with anyone yet.';
  static const String deleteLocationConfirmationTitle = 'Delete location';
  static const String deleteLocationConfirmationDescription = 'Are you sure you want to delete the location?';
  static const String deleteLocationConfirmationButton = 'Yes';
  static const String deleteWeatherStationConfirmationTitle = 'Delete weather station';
  static const String deleteWeatherStationConfirmationDescription =
      'Are you sure you want to delete the weather station?';
  static const String deleteWeatherStationConfirmationButton = 'Yes';
  static const String deleteSolarTrackerConfirmationTitle = 'Delete solar tracker';
  static const String deleteSolarTrackerConfirmationDescription = 'Are you sure you want to delete this solar tracker?';
  static const String deleteSolarTrackerConfirmationButton = 'Yes';
  static const String deleteSolarTracker = 'Delete solar tracker';
  static const String deletedSolarTracker = 'The solar tracker has been deleted';
  static const String deletedLocation = 'The location has been deleted';
  static const String inviteUserDialogTitle = 'Invite user';
  static const String inviteUserButton = 'Invite';
  static const String inviteUserFailedBecauseOfLocationNotExists = 'Location does not exist anymore';
  static const String invalidEmail = 'Invalid email';
  static const String delete = 'Delete';
  static const String userWasInvitedSuccessfully = 'User was invited successfully';
  static const String userNotFound = 'User not found';

  static const String futureDevelopmentLabel = 'This feature is for future development.';

  static const String noPublicationsTitle = 'No publications yet';
  static const String noPublicationsDescription = 'You will see publications here.';
  static const String errorFetchingPublicationsTitle = 'Error fetching publications';
  static const String errorFetchingPublicationsDescription = 'Please try again later.';
  static const String productCategories = 'Product categories';
  static const String serviceCategories = 'Service categories';
  static const String applyFiltersButton = 'Apply filters';
  static String invalidPublicationTitleLength(int minLength, int maxLength) =>
      'Publication title length must be between $minLength and $maxLength characters';
  static const String addPublicationPageTitle = 'Add new publication';
  static const String addPublicationButton = 'Add publication';
  static const String publicationTypeSectionTitle = 'Publication type';
  static const String publicationTitleSectionTitle = 'Title';
  static const String publicationDescriptionSectionTitle = 'Description';
  static const String publicationPriceSectionTitle = 'Price';
  static const String publicationCategorySectionTitle = 'Category';
  static const String publicationImagesSectionTitle = 'Images';
  static const String publicationProductConditionSectionTitle = 'Condition';
  static const String publicationUserDetailsSectionTitle = 'User details';
  static const String nagotiablePrice = 'Negotiable price';
  static const String serviceDetailsPageTitle = 'Service details';
  static const String productDetailsPageTitle = 'Product details';
  static const String readMore = 'read more';
  static const String showLess = ' show less';
  static String productCondition(String condition) => 'Product is ${condition.toLowerCase()}';
  static const String deletePublicationConfirmationTitle = 'Delete publication';
  static const String deletePublicationConfirmationDescription = 'Are you sure you want to delete the publication?';
  static const String deletePublicationConfirmationButton = 'Yes';

  static const String solarTrackerAlreadyDeleted = 'Error! Solar tracker already deleted';

  static const String productPublicationType = 'Product';
  static const String servicePublicationType = 'Service';

  static const String solarPanelsProductCategory = 'Solar panels';
  static const String invertersProductCategory = 'Inverters';
  static const String batteriesProductCategory = 'Batteries';
  static const String chargeControllersProductCategory = 'Charge controllers';
  static const String motorsProductCategory = 'Motors';
  static const String cablesAndConnectorsProductCategory = 'Cables & Connectors';
  static const String otherProductCategory = 'Other';

  static const String newProductCondition = 'New';
  static const String usedProductCondition = 'Used';

  static const String cleaningServiceCategory = 'Cleaning';
  static const String legalConsultingServiceCategory = 'Legal consulting';
  static const String designingServiceCategory = 'Designing';
  static const String performanceAnalysisServiceCategory = 'Performance analysis';
  static const String installationServiceCategory = 'Installation';
  static const String otherServiceCategory = 'Other';

  static const String fixedPricingOption = 'Fixed';
  static const String negotiablePricingOption = 'Negotiable';

  static String invitationTitle(String ownerUsername, String locationName) =>
      '$ownerUsername invited you to join location named $locationName';
}
