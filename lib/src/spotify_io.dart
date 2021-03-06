// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of spotify;

class SpotifyApi extends SpotifyApiBase {
  SpotifyApi(SpotifyApiCredentials credentials) : super(credentials);

  @override
  Future<String> _getImpl(String url, Map<String, String> headers) async {
    var client = new http.Client();
    var response = await client.get(url, headers: headers);
    return handleErrors(response);
  }

  @override
  Future<String> _postImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var client = new http.Client();
    var response = await client.post(url, headers: headers, body: body);
    return handleErrors(response);
  }

  @override
  Future<String> _putImpl(
      String url, Map<String, String> headers, dynamic body) async {
    var client = new http.Client();
    var response = await client.put(url, headers: headers, body: body);
    return handleErrors(response);
  }

  String handleErrors(http.Response response) {
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode >= 400) {
      var jsonMap = json.decode(responseBody);
      throw new SpotifyException.fromSpotify(
        SpotifyError.fromJson(jsonMap['error']),
      );
    }
    return responseBody;
  }
}
