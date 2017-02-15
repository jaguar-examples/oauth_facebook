library oauth_facebook.server.db.mongo.datastore.user;

import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart' as mgo;
import 'package:oauth_facebook/server/models/user.dart' as model;
import 'package:oauth_facebook/server/db/common/datastore/user.dart';

import 'package:oauth_facebook/server/db/mongo/serializer/user.dart';

class MongoUserStore implements UserStore {
  mgo.DbCollection _coll;

  MongoUserStore(mgo.Db _db) {
    _coll = _db.collection('user');
  }

  Map _encode(model.User user) => serializer.toMap(user);

  model.User _decode(Map map) => serializer.fromMap(map);

  Future<String> create(model.User user) async {
    final String id = new mgo.ObjectId().toHexString();
    user.id = id;
    await _coll.insert(_encode(user));
    return id;
  }

  Future<model.User> getById(String id) async {
    Map map = await _coll.findOne(mgo.where.id(mgo.ObjectId.parse(id)));
    return _decode(map);
  }

  Future<model.User> getByEmail(String email) async {
    Map map = await _coll.findOne(mgo.where.eq('email', email));
    return _decode(map);
  }

  Future<model.User> getByFbId(String fbId) async {
    Map map = await _coll.findOne(mgo.where.eq('email', fbId));
    return _decode(map);
  }

  Future setFbInfo(String id, String fbId, String token, String refreshToken) async {
    final upd = mgo.modify;
    upd.set('fbId', fbId);
    upd.set('fbToken', token);
    upd.set('fbRefreshToken', refreshToken);

    await _coll.update(mgo.where.id(mgo.ObjectId.parse(id)), upd);
  }

  final UserSerializer serializer = new UserSerializer();
}