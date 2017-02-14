part of oauth_facebook.server.api;

/// Facebook oauth configuration
final JaguarOauth2Config _facebook = new JaguarOauth2Config(
    key: Settings.getString('facebook_oauth_key'),
    secret: Settings.getString('facebook_oauth_secret'),
    authorizationEndpoint: 'https://www.facebook.com/dialog/oauth',
    tokenEndpoint: 'https://graph.facebook.com/v2.8/oauth/access_token',
    callback: Settings.getString('baseurl') + '/api/auth/fb/authorized',
    scopes: [fb.Scope.email, fb.Scope.userAboutMe, fb.Scope.publicProfile]);