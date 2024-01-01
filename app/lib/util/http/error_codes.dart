enum ErrorCode {
  // Bad Request:
  genericBadRequest(4000),
  tooShortUsername(4001), // TODO: fix this
  weakPassword(4003),
  invalidLocationNameLength(4004),
  invalidSTSerialNumber(4005),
  invalidWSSerialNumber(4006),
  solarTrackersArrayMustContainAtLeastOneSerialNumber(4007),
  // Unauthorized:
  invalidEmail(4011),
  invalidPassword(4012),
  // Conflict:
  emailAlreadyUsed(4091), // not used yet
  locationAlreadyAdded(4093);

  final int code;
  const ErrorCode(this.code);
}
