part of oauth_facebook.server.api;

class MongoUserManager implements FacebookModelManager {
  UserStore _store;

  Future<User> fetchModelByAuthenticationId(String authenticationId) =>
      _store.getByEmail(authenticationId);

  Future<User> fetchModelByAuthorizationId(String authorizationId) =>
      _store.getByFbId(authorizationId);

  Future<User> authenticate(String authId, String keyword) async {
    User user = await fetchModelByAuthenticationId(authId);
    if (user == null) return null;
    if (user.authenticationKeyword != keyword) return null;
    return user;
  }

  Future<User> fetchModelByFbId(String fbId) => _store.getByFbId(fbId);

  Future<Null> setFbInfo(FacebookUserModel model, String fbId, String fbToken,
      String fbRefreshToken) =>
      _store.setFbInfo(model.authorizationId, fbId, fbToken, fbRefreshToken);
}