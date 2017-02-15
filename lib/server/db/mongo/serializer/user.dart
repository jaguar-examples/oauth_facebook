library server.serializer.user;

import 'package:jaguar_serializer/serializer.dart';
import 'package:jaguar_serializer_mongo/jaguar_serializer_mongo.dart';

import 'package:oauth_facebook/server/models/user.dart';

part 'user.g.dart';

@GenSerializer()
@MongoId(#id)
@EnDecodeField(#id, asAndFrom: '_id')
class UserSerializer extends _$UserSerializer implements MapSerializer<User> {
  User createModel() => new User();
}