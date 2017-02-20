part of oauth_facebook.server.api;

/// Route for signup, login and logout routes
@RouteGroup()
@Wrap(const [#mongoDb, #sessionInterceptor])
class AuthRoutes {
  @Post(path: '/signup')
  @WrapDecodeJsonMap()
  Future<Null> signup(
      @Input(DecodeJsonMap) Map body, @Input(MongoDb) Db db) async {
    User user = _userSerializer.fromMap(body);
    //TODO: validate
    UserStore _store = new MongoUserStore(db);
    await _store.create(user);
  }

  @Post(path: '/login')
  @Wrap(const [#usernamePasswordJsonAuth])
  void login(Request req) {}

  @Post(path: '/logout')
  void logout() {
    //TODO logout
  }

  WrapMongoDb mongoDb() => new WrapMongoDb(Settings.getString('mongo.url'));

  WrapSessionInterceptor sessionInterceptor() =>
      new WrapSessionInterceptor(sessionManager());

  WrapUsernamePasswordJsonAuth usernamePasswordJsonAuth(
          @Input(MongoDb) Db db) =>
      new WrapUsernamePasswordJsonAuth(userManager(db));

  CookieSessionManager sessionManager() => new CookieSessionManager();

  MongoUserManager userManager(Db db) =>
      new MongoUserManager(new MongoUserStore(db));
}
