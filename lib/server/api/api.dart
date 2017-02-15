library oauth_facebook.server.api;

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/interceptors.dart';
import 'package:jaguar_oauth/jaguar_oauth.dart';
import 'package:jaguar_facebook_client/jaguar_facebook_client.dart' as fb;
import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:jaguar_session/jaguar_session.dart';
import 'package:oauth_facebook/server/models/user.dart';
import 'package:jaguar_oauth_facebook/jaguar_oauth_facebook.dart';
import 'package:oauth_facebook/server/db/common/datastore/user.dart';
import 'package:jaguar_mongo/jaguar_mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:oauth_facebook/common/serializer/user.dart';
import 'package:oauth_facebook/server/db/mongo/datastore/user.dart';

part 'user_manager.dart';
part 'fb_config.dart';
part 'group_auth.dart';
part 'group_fb.dart';

final UserSerializer _userSerializer = new UserSerializer();

@Api(path: '/api')
class MyApi {
  @Group(path: '/auth')
  final FbAuthRoutes fbAuth = new FbAuthRoutes();

  @Group(path: '/fb')
  final AuthRoutes auth = new AuthRoutes();
}
