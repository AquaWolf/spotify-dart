// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library spotify.token;

import 'package:json_annotation/json_annotation.dart';

part 'token_request.g.dart';

enum GrantType {
  authorizationCode,
  refreshToken,
  clientCredentials,
  implicitGrant
}

@JsonSerializable()
class TokenRequest extends Object with _$TokenRequestSerializerMixin {
  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);

  TokenRequest([this._grantType = GrantType.clientCredentials]) {
    grantTypeString = this.toString();
  }

  @JsonKey(name: 'grant_type')
  String grantTypeString;

  @JsonKey(ignore: true)
  GrantType _grantType;

  @JsonKey(ignore: true)
  GrantType get grantType => _grantType;

  @override
  String toString() {
    switch (_grantType) {
      case GrantType.authorizationCode:
        return 'authorization_code';
      case GrantType.refreshToken:
        return 'refresh_token';
      case GrantType.clientCredentials:
        return 'client_credentials';
      default:
        throw new UnsupportedError(
            'Unsupported grant type: ${_grantType.toString()}'
        );
    }
  }
}

@JsonSerializable()
class ApiToken extends Object with _$ApiTokenSerializerMixin {
  ApiToken() {}
  factory ApiToken.fromJson(Map<String, dynamic> json) => _$ApiTokenFromJson(json);

  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  @JsonKey(name: 'token_type')
  String tokenType;

  @JsonKey(name: 'expires_in')
  int expiresIn;

  @JsonKey(ignore: true)
  DateTime _createdOn = new DateTime.now();
  bool get isExpired =>
      _createdOn.difference(new DateTime.now()).inSeconds.abs() > expiresIn;

  @JsonKey(ignore: true)
  GrantType _grantType = GrantType.clientCredentials;
  @JsonKey(ignore: true)
  GrantType get grantType => _grantType;
  @JsonKey(ignore: true)
  GrantType _refreshGrantType = GrantType.clientCredentials;
  @JsonKey(ignore: true)
  GrantType get refreshGrantType => _refreshGrantType;

  @JsonKey(ignore: true)
  bool get canRefresh => _grantType == GrantType.clientCredentials ||
      _grantType == GrantType.authorizationCode;

  ApiToken.implicitGrant(String accessToken, int expiresIn) {
    this.accessToken = accessToken;
    this.tokenType = 'Bearer';
    this.expiresIn = expiresIn;

    _grantType = GrantType.implicitGrant;
  }

  ApiToken.authorizationCode(String accessToken, String refreshToken, int expiresIn) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    this.tokenType = 'Bearer';
    this.expiresIn = expiresIn;

    _grantType = GrantType.authorizationCode;
    _refreshGrantType = GrantType.refreshToken;
  }
}
