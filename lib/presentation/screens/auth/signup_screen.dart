import 'package:avsar/presentation/screens/auth/login_screen.dart';
import 'package:avsar/presentation/screens/auth/providers/signup_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/ui.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/bottomsheet_widget.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/primary_textfield_password.dart';
import '../splash/splash_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  
  static const String routeName = "signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserRegistrationInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
        if (provider.error.isNotEmpty){
          CommonWidget.showSnackBar(context, provider.error);
          Navigator.pop(context);
        }
        if(provider.isLoading){
          CommonWidget.buildShowDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Form(
            key: provider.formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                Text("Create Account", style: TextStyles.heading2),
                const GapWidget(size: -10),

                (provider.error != "") ? Text(
                  provider.error,
                  style: const TextStyle(color: Colors.red),
                ) : const SizedBox(),

                const GapWidget(size: 5),

                PrimaryTextField(
                  controller: provider.emailController,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return "Email address is required!";
                    }

                    if(!EmailValidator.validate(value.trim())) {
                      return "Invalid email address";
                    }

                    return null;
                  },
                  labelText: "Email Address",
                    prefixIcon: const Icon(Icons.email),
                ),

                const GapWidget(),

                PrimaryTextField(
                    controller: provider.userNameController,
                    validator: (value) {
                      if(value == null || value.trim().isEmpty) {
                        return "UserName is required!";
                      }

                      if(value.trim().length<2) {
                        return "Please enter minimum 3 character";
                      }

                      return null;
                    },
                    labelText: "UserName",
                    prefixIcon: const Icon(Icons.person)
                ),

                const GapWidget(),

                PrimaryTextFieldPassword(
                  source: SignupScreen.routeName,
                  controller: provider.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return "Pin is required!";
                    }
                    return null;
                  },
                  labelText: "Pin",
                    prefixIcon: const Icon(Icons.lock)
                ),

                const GapWidget(),

                PrimaryTextFieldPassword(
                  source: SignupScreen.routeName,
                  controller: provider.cPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.trim().isEmpty) {
                      return "Confirm your pin!";
                    }

                    if(value.trim() != provider.passwordController.text.trim()) {
                      return "Pin do not match!";
                    }

                    return null;
                  },
                  labelText: "Confirm Pin",
                    prefixIcon: const Icon(Icons.lock)
                ),

                const GapWidget(),

                PrimaryButton(
                  onPressed: provider.createAccount,
                  text: "Create Account"
                ),

                const GapWidget(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Already have an account?", style: TextStyles.body2),

                    const GapWidget(),

                    LinkButton(
                      onPressed: () {
                       // Navigator.pushNamed(context, LoginScreen.routeName);
                        showBottomSheetDisplay();
                      },
                      text: "Log In"
                    )
                  ],
                ),

              ]
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheetDisplay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          title: 'Select an Item',
          items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4','Item 5', 'Item 6', 'Item 7', 'Item 8'],
          onItemSelected: (selectedItem) {
            // Handle the selected item here
            print('Selected: $selectedItem');
          },
        );
      },
    );
  }
}