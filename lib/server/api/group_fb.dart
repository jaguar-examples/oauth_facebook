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
  @Get(path: '/req/auth')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbReqAuth() {}

  @Get(path: '/authorized/auth', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  @WrapFacebookAuth(null, makeParams: const {
    #manager: const MakeParamFromMethod(#userManager),
  })
  void fbAuthorizedAuth() {}

  @Get(path: '/req/signup')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbReqSignup() {}

  @Get(path: '/authorized/signup', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  @WrapFacebookAuth(null, makeParams: const {
    #manager: const MakeParamFromMethod(#userManager),
  })
  void fbAuthorizedSignup() {}

  @Get(path: '/req/link')
  @WrapOAuth2Req(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  void fbReqLink() {}

  @Get(path: '/authorized/link', mimeType: 'application/json')
  @WrapOAuth2Authorized(null, makeParams: const {
    #config: const MakeParamFromMethod(#facebook),
  })
  @WrapFacebookAuth(null, makeParams: const {
    #manager: const MakeParamFromMethod(#userManager),
  })
  void fbAuthorizedLink() {}

  JaguarOauth2Config facebook() => _facebook;

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(@Input(MongoDb) Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}