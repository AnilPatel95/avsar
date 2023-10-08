import 'package:avsar/data/models/user/user_model.dart';
import 'package:avsar/data/repositories/user_repository.dart';
import 'package:avsar/logic/cubits/user_cubit/user_state.dart';
import 'package:avsar/logic/services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user/register_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super( UserInitialState() ) {
    _initialize();
  }
  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails["email"];
    String? password = userDetails["password"];

    if(email == null || password == null) {
      emit( UserLoggedOutState() );
    }
    else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState({
    required UserModel userModel,
    required String email,
    required String password
  }) async {
    await Preferences.saveUserDetails(email, password);
    final data = userModel.data;
    if(data !=null){
      await Preferences.saveToken(data.token.toString(), data.refreshToken.toString());
    }
    emit( UserLoggedInState(userModel) );
  }

  void signIn({
    required String email,
    required String password
  }) async {
    emit( UserLoadingState() );
    try {
      UserModel userModel = await _userRepository.signIn(email: email, pin: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
    }
  }

  void createAccount({
    required String id,
    required String userEmail,
    required String userFriendlyName,
    required String userPin
  }) async {
    emit( UserLoadingState() );
    try {
      RegisterModel registrationModel = await _userRepository.createAccount(
          id: id,
          userEmail: userEmail,
          userFriendlyName: userFriendlyName,
          userPin: userPin);
      _emitRegistrationInState(registrationModel: registrationModel, email: userEmail, password: userPin);
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
    }
  }

  void _emitRegistrationInState({
    required RegisterModel registrationModel,
    required String email,
    required String password
  }) async {
    await Preferences.saveUserDetails(email, password);
    final data = registrationModel.data;
    emit( UserRegistrationInState(registrationModel) );
  }


  void signOut() async {
    await Preferences.clear();
    emit( UserLoggedOutState() );
  }
}