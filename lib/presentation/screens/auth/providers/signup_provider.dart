import 'dart:async';
import 'package:avsar/logic/cubits/user_cubit/user_cubit.dart';
import 'package:avsar/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProvider with ChangeNotifier {
  final BuildContext context;
  SignupProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoading = false;
  bool _isPasswordVisible = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if(userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      }
      else if(userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      }
      else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    if(!formKey.currentState!.validate()) return;

    String userEmail = emailController.text.trim();
    String userPin = passwordController.text.trim();
    String userName = userNameController.text.trim();

    BlocProvider.of<UserCubit>(context).createAccount(
        id: "1",
        userEmail: userEmail,
        userFriendlyName: userName,
        userPin: userPin);
  }

  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility(){
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}