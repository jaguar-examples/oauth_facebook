library oauth_facebook.server.db.ds.datastore.user;

/*TODO
import 'dart:async';
import 'package:jaguar_docstore/jaguar_docstore.dart';
import 'package:oauth_facebook/server/models/user.dart' as model;
import 'package:oauth_facebook/server/db/common/datastore/user.dart';

class DsUserStore implements UserStore {
  final CollectionInMem _coll;

  DsUserStore(this._coll);

  Map _encode(model.User user) {
    //TODO
    return {};
  }

  model.User _decode(Map map) {
    //TODO
    return new model.User();
  }

  Future<String> create(model.User user) async {
    //TODO
  }

  Future<model.User> getById(String id) async {
    final Map map = await _coll.findById(id);
    return _decode(map);
  }

  Future<model.User> getByEmail(String email) async {
    final Map map =
        await _coll.findOne(new RelationalCondition.eq('email', email));
    return _decode(map);
  }

  Future<model.User> getByFbId(String fbId) async {
    final Map map = await _coll.findOne(new RelationalCondition.eq('fbId', fbId));
    return _decode(map);
  }

  Future setFbInfo(
      String id, String fbId, String token, String refreshToken) async {
    //TODO
  }
}
*/