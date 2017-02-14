library server.models.user;

import 'package:jaguar_auth/jaguar_auth.dart';
import 'package:jaguar_oauth_facebook/jaguar_oauth_facebook.dart';

/// User model
class User implements UserModel, FacebookUserModel {
  /// ID for the user in the database
  String id;

  /// User name
  String name;

  /// User's email
  String email;

  String password;

  String dateOfBirth;

  String bio;

  /// Token to access user's facebook account
  String fbToken;

  /// Token to refresh user's facebook account token [fbToken]
  //TODO needed? String fbRefreshToken;

  /// Facebook ID of the user
  String fbId;

  String get authenticationId => email;

  String get authenticationKeyword => password;

  //TODO use id instead
  String get authorizationId => email;
}