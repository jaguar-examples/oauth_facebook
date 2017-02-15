library server.serializer.user;

import 'package:jaguar_serializer/serializer.dart';
import 'package:oauth_facebook/server/models/user.dart';

part 'user.g.dart';

@GenSerializer()
class UserSerializer extends _$UserSerializer implements MapSerializer<User> {
  User createModel() => new User();
}