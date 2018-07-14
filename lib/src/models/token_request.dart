// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library spotify.token;

import 'package:json_annotation/json_annotation.dart';

part 'token_request.g.dart';

@JsonSerializable()
class TokenRequest extends Object with _$TokenRequestSerializerMixin {
  TokenRequest() {}
  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);

  @JsonKey(name: 'grant_type')
  String grantType = 'client_credentials';
}

@JsonSerializable()
class ApiToken extends Object with _$ApiTokenSerializerMixin {
  ApiToken() {}
  factory ApiToken.fromJson(Map<String, dynamic> json) => _$ApiTokenFromJson(json);

  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'token_type')
  String tokenType;

  @JsonKey(name: 'expires_in')
  int expiresIn;

  @JsonKey(ignore: true)
  DateTime _createdOn = new DateTime.now();
  bool get isExpired =>
      _createdOn.difference(new DateTime.now()).inSeconds.abs() > expiresIn;
}
