enum ErrorCode {
  // Bad Request:
  genericBadRequest(4000),
  tooShortUsername(4001),
  weakPassword(4002),
  tooLongLocationName(4003),
  invalidSTSerialNumber(4004),
  invalidWSSerialNumber(4005),
  invalidLocationUuid(4006),
  // Unauthorized:
  invalidEmail(4011),
  invalidPassword(4012),
  invalidAccessToken(4013),
  // Conflict:
  emailAlreadyUsed(4091), // not used yet
  stSerialNumberAlreadyUsed(4092),
  locationAlreadyAdded(4093),
  // Internal Server Error:
  failedToAddLocation(5001);

  final int code;
  const ErrorCode(this.code);
}
