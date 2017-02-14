import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/interceptors.dart';
import 'package:jaguar_oauth/jaguar_oauth.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:jaguar_facebook_client/jaguar_facebook_client.dart' as fb;
import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:jaguar_session/jaguar_session.dart';
import 'package:oauth_facebook/server/models/user.dart';
import 'package:jaguar_oauth_facebook/jaguar_oauth_facebook.dart';
import 'package:jaguar_docstore/jaguar_docstore.dart';

import 'package:oauth_facebook/server/serializer/user_serializer.dart';

final CollectionInMem _coll = new CollectionInMem();

final UserSerializer _userSerializer = new UserSerializer();

class MyModelManager implements AuthModelManager, FacebookModelManager {
  User _toModel(Map map) => _userSerializer.fromMap(map);

  Future<UserModel> fetchModelByAuthenticationId(
      String authenticationId) async {
    final Map map = await _coll
        .findOne(new RelationalCondition.eq('name', authenticationId));
    if (map == null) return null;
    return _toModel(map);
  }

  Future<UserModel> fetchModelByAuthorizationId(String authorizationId) async {
    final Map map =
        await _coll.findOne(new RelationalCondition.eq('_id', authorizationId));
    if (map == null) return null;
    return _toModel(map);
  }

  Future<UserModel> authenticate(String authId, String keyword) async {
    User user = await fetchModelByAuthenticationId(authId);
    if (user == null) return null;
    if (user.authenticationKeyword != keyword) return null;
    return user;
  }

  Future<FacebookUserModel> fetchModelByFbId(String fbId) async {
    final Map map =
        await _coll.findOne(new RelationalCondition.eq('fbId', fbId));
    if (map == null) return null;
    return _toModel(map);
  }
}

final MyModelManager _modelManager = new MyModelManager();

/// Facebook oauth configuration
final JaguarOauth2Config _facebook = new JaguarOauth2Config(
    key: Settings.getString('facebook_oauth_key'),
    secret: Settings.getString('facebook_oauth_secret'),
    authorizationEndpoint: 'https://www.facebook.com/dialog/oauth',
    tokenEndpoint: 'https://graph.facebook.com/v2.8/oauth/access_token',
    callback: Settings.getString('baseurl') + '/api/auth/fb/authorized',
    scopes: [fb.Scope.email, fb.Scope.userAboutMe, fb.Scope.publicProfile]);

final Map<String, User> users = {};

/// Routes for facebook signup and login
@RouteGroup()
@WrapSessionInterceptor(makeParams: const <Symbol, MakeParam>{
  #sessionManager: const MakeParamFromMethod(#sessionManager)
})
class FbAuthRoutes {
  @Get(path: '/fb/authreq')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbAuthReq() {}

  @Get(path: '/fb/authorized', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  @WrapFacebookAuth(null, makeParams: const {
    #manager: const MakeParamFromMethod(#userManager),
  })
  void fbAuthorized() {}

  JaguarOauth2Config facebook() => _facebook;

  CookieSessionManager sessionManager() => new CookieSessionManager();

  FacebookModelManager userManager() => _modelManager;
}

/// Route for signup, login and logout routes
@RouteGroup()
@WrapSessionInterceptor(makeParams: const <Symbol, MakeParam>{
  #sessionManager: const MakeParamFromMethod(#sessionManager)
})
class AuthRoutes {
  @Post(path: '/signup')
  @WrapDecodeJsonMap()
  Future<Null> signup(@Input(DecodeJsonMap) Map body) async {
    User user = _userSerializer.fromMap(body);
    //TODO: validate
    await _coll.insert(_userSerializer.toMap(user));
  }

  @Post(path: '/login')
  @WrapBasicAuth(makeParams: const <Symbol, MakeParam>{
    #modelManager: const MakeParamFromMethod(#userManager)
  })
  void login(Request req) {}

  @Post(path: '/logout')
  void logout() {
    //TODO logout
  }

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MyModelManager userManager() => _modelManager;
}

@Api(path: '/api')
class MyApi {
  @Group(path: '/auth')
  final FbAuthRoutes fbAuth = new FbAuthRoutes();

  @Group(path: '/fb')
  final AuthRoutes auth = new AuthRoutes();
}
