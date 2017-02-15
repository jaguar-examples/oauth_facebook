part of oauth_facebook.server.api;

/// Routes for facebook signup and login
@RouteGroup()
@WrapMongoDb(null, makeParams: const <Symbol, MakeParam> {
  #mongoUri: const MakeParamFromSettings('mongo.url'),
})
@WrapSessionInterceptor(makeParams: const <Symbol, MakeParam>{
  #sessionManager: const MakeParamFromMethod(#sessionManager)
})
class FbAuthRoutes {
  @Get(path: '/authreq')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbAuthReq() {}

  @Get(path: '/authorized', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  @WrapFacebookAuth(null, makeParams: const {
    #manager: const MakeParamFromMethod(#userManager),
  })
  void fbAuthorized() {}

  JaguarOauth2Config facebook() => _facebook;

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(@Input(MongoDb) Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}