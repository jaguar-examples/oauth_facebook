part of oauth_facebook.server.api;

/// Routes to access user
@RouteGroup()
@WrapMongoDb(null, makeParams: const <Symbol, MakeParam>{
  #mongoUri: const MakeParamFromSettings('mongo.url'),
})
@WrapSessionInterceptor(makeParams: const <Symbol, MakeParam>{
  #sessionManager: const MakeParamFromMethod(#sessionManager)
})
@WrapUserAuthoriser(null, makeParams: const <Symbol, MakeParam>{
  #modelManager: const MakeParamFromMethod(#userManager)
})
class UserRoutes {
  @Get()
  @WrapEncodeMapToJson()
  Map get(@Input(UserAuthoriser) User user) => _userSerializer.toMap(user);

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(@Input(MongoDb) Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}
