part of oauth_facebook.server.api;

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