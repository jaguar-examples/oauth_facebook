import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_oauth/jaguar_oauth.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:jaguar_facebook_client/jaguar_facebook_client.dart' as fb;

const JaguarOauth2Config facebook = const JaguarOauth2Config();

@RouteGroup(path: '/auth')
class AuthRoutes {
  @Get(path: '/fb/authreq')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbAuthReq() {}

  @Get(path: '/fb/authorized', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  Future<String> fbAuthorized(
      @Input(OAuth2Authorized) oauth2.Client client) async {
    final graph = new fb.GraphApi(client);
    final fields = new fb.UserFieldSelector()
      ..addBirthday()
      ..addAbout()
      ..addEmail()
      ..addName();
    final resp = await graph.getMe(fields: fields);
    return resp.map.toString();
  }

  JaguarOauth2Config facebook() => new JaguarOauth2Config(
      key: Settings.getString('facebook_oauth_key'),
      secret: Settings.getString('facebook_oauth_secret'),
      authorizationEndpoint: 'https://www.facebook.com/dialog/oauth',
      tokenEndpoint: 'https://graph.facebook.com/v2.8/oauth/access_token',
      callback: Settings.getString('baseurl') + '/api/auth/fb/authorized',
      scopes: [fb.Scope.email, fb.Scope.userAboutMe, fb.Scope.publicProfile]);
}

@Api(path: '/api')
class MyApi {
  @Group()
  final AuthRoutes auth = new AuthRoutes();
}