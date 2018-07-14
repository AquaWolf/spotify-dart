// GENERATED CODE - DO NOT MODIFY BY HAND

part of spotify.token;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) {
  return new TokenRequest()..grantTypeString = json['grant_type'] as String;
}

abstract class _$TokenRequestSerializerMixin {
  String get grantTypeString;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'grant_type': grantTypeString};
}

ApiToken _$ApiTokenFromJson(Map<String, dynamic> json) {
  return new ApiToken()
    ..accessToken = json['access_token'] as String
    ..refreshToken = json['refresh_token'] as String
    ..tokenType = json['token_type'] as String
    ..expiresIn = json['expires_in'] as int;
}

abstract class _$ApiTokenSerializerMixin {
  String get accessToken;
  String get refreshToken;
  String get tokenType;
  int get expiresIn;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'token_type': tokenType,
        'expires_in': expiresIn
      };
}
