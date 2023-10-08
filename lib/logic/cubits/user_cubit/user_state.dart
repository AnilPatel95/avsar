
import 'package:avsar/data/models/user/register_model.dart';
import 'package:avsar/data/models/user/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoggedInState extends UserState {
  final UserModel userModel;
  UserLoggedInState(this.userModel);
}

class UserRegistrationInState extends UserState {
  final RegisterModel registrationModel;
  UserRegistrationInState(this.registrationModel);
}

class UserLoggedOutState extends UserState {}

class UserErrorState extends UserState  {
  final String message;
  UserErrorState(this.message);
}