library server.serializer.user;

import 'package:jaguar_serializer/serializer.dart';

import 'package:oauth_facebook/server/models/user.dart';

part 'user_serializer.g.dart';

@GenSerializer()
@EnDecodeField(#id, asAndFrom: '_id')
class UserSerializer extends _$UserSerializer implements MapSerializer<User> {
  User createModel() => new User();
}