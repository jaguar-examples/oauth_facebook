// GENERATED CODE - DO NOT MODIFY BY HAND

part of server.serializer.user;

// **************************************************************************
// Generator: SerializerGenerator
// Target: class UserSerializer
// **************************************************************************

abstract class _$UserSerializer implements MapSerializer<User> {
  Map toMap(User model) {
    Map ret = new Map();
    if (model != null) {
      if (model.id != null) {
        ret["_id"] = new MongoId(#id).to(model.id);
      }
      if (model.name != null) {
        ret["name"] = model.name;
      }
      if (model.email != null) {
        ret["email"] = model.email;
      }
      if (model.password != null) {
        ret["password"] = model.password;
      }
      if (model.dateOfBirth != null) {
        ret["dateOfBirth"] = model.dateOfBirth;
      }
      if (model.bio != null) {
        ret["bio"] = model.bio;
      }
      if (model.fbToken != null) {
        ret["fbToken"] = model.fbToken;
      }
      if (model.fbRefreshToken != null) {
        ret["fbRefreshToken"] = model.fbRefreshToken;
      }
      if (model.fbId != null) {
        ret["fbId"] = model.fbId;
      }
      if (model.authenticationId != null) {
        ret["authenticationId"] = model.authenticationId;
      }
      if (model.authenticationKeyword != null) {
        ret["authenticationKeyword"] = model.authenticationKeyword;
      }
      if (model.authorizationId != null) {
        ret["authorizationId"] = model.authorizationId;
      }
    }
    return ret;
  }

  User fromMap(Map map, {User model}) {
    if (map is! Map) {
      return null;
    }
    if (model is! User) {
      model = createModel();
    }
    model.id = new MongoId(#id).from(map["_id"]);
    model.name = map["name"];
    model.email = map["email"];
    model.password = map["password"];
    model.dateOfBirth = map["dateOfBirth"];
    model.bio = map["bio"];
    model.fbToken = map["fbToken"];
    model.fbRefreshToken = map["fbRefreshToken"];
    model.fbId = map["fbId"];
    return model;
  }
}
