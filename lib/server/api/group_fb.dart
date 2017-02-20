part of oauth_facebook.server.api;

/// Routes for facebook signup and login
@RouteGroup()
@Wrap(const [#mongoDb, #sessionInterceptor])
class FbAuthRoutes {
  @Get(path: '/req/auth')
  @Wrap(const [#oAuth2Req])
  void fbReqAuth() {}

  @Get(path: '/authorized/auth', mimeType: 'application/json')
  @Wrap(const [#oAuth2Authorized, #facebookAuth])
  void fbAuthorizedAuth() {}

  @Get(path: '/req/signup')
  @Wrap(const [#oAuth2Req])
  void fbReqSignup() {}

  @Get(path: '/authorized/signup', mimeType: 'application/json')
  @Wrap(const [#oAuth2Authorized])
  void fbAuthorizedSignup(@Input(OAuth2Authorized) oauth2.Client client) {
    //TODO signup
  }

  @Get(path: '/req/link')
  @Wrap(const [#oAuth2Req])
  void fbReqLink() {}

  //TODO add UserAuthorizer
  @Get(path: '/authorized/link', mimeType: 'application/json')
  @Wrap(const [#userAuthoriser, #oAuth2Authorized, #linkFacebook])
  void fbAuthorizedLink() {}

  WrapOAuth2Req oAuth2Req() => new WrapOAuth2Req(facebook());

  WrapOAuth2Authorized oAuth2Authorized() =>
      new WrapOAuth2Authorized(facebook());

  WrapFacebookAuth facebookAuth(@Input(MongoDb) Db db) =>
      new WrapFacebookAuth(userManager(db));

  WrapLinkFacebook linkFacebook(@Input(MongoDb) Db db) =>
      new WrapLinkFacebook(userManager(db));

  WrapUserAuthoriser userAuthoriser(@Input(MongoDb) Db db) =>
      new WrapUserAuthoriser(userManager(db));

  JaguarOauth2Config facebook() => _facebook;

  WrapMongoDb mongoDb() => new WrapMongoDb(Settings.getString('mongo.url'));

  WrapSessionInterceptor sessionInterceptor() =>
      new WrapSessionInterceptor(sessionManager());

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}
