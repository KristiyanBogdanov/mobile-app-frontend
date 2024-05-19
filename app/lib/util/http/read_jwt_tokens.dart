String readAccessTokenFromJsonBody(Map<String, dynamic> jsonBody) {
  return jsonBody['accessToken'];
}

String readRefreshTokenFromJsonBody(Map<String, dynamic> jsonBody) {
  return jsonBody['refreshToken'];
}
