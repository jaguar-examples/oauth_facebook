part of oauth_facebook.server.api;

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
    UserStore _store;
    //TODO: validate
    await _store.create(user);
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

  MongoUserManager userManager() => _modelManager;
}