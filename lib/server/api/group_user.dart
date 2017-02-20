part of oauth_facebook.server.api;

/// Routes to access user
@RouteGroup()
@Wrap(const [#mongoDb, #sessionInterceptor, #userAuthoriser])
class UserRoutes {
  @Get()
  @WrapEncodeMapToJson()
  Map get(@Input(UserAuthoriser) User user) => _userSerializer.toMap(user);

  WrapMongoDb mongoDb() => new WrapMongoDb(Settings.getString('mongo.url'));

  WrapSessionInterceptor sessionInterceptor() =>
      new WrapSessionInterceptor(sessionManager());

  WrapUserAuthoriser userAuthoriser(@Input(MongoDb) Db db) =>
      new WrapUserAuthoriser(userManager(db));

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}
