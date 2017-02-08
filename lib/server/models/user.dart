library server.models.user;

/// User model
class User {
  /// ID for the user in the database
  String id;

  /// User name
  String name;

  /// User's email
  String email;

  String dateOfBirth;

  String bio;

  /// Token to access user's facebook account
  String fbToken;

  /// Token to refresh user's facebook account token [fbToken]
  //TODO needed? String fbRefreshToken;

  /// Facebook ID of the user
  String fbId;
}