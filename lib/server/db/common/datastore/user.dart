library oauth_facebook.server.common.mongo.datastore.user;

import 'dart:async';
import 'package:oauth_facebook/server/models/user.dart' as model;

abstract class UserStore {
  Future<String> create(model.User user);

  Future<model.User> getById(String id);

  Future<model.User> getByEmail(String email);

  Future<model.User> getByFbId(String fbId);

  Future setFbInfo(String id, String fbId, String token, String refreshToken);
}