import 'package:avsar/core/ui.dart';
import 'package:avsar/logic/cubits/user_cubit/user_cubit.dart';
import 'package:avsar/logic/cubits/user_cubit/user_state.dart';
import 'package:avsar/presentation/screens/auth/providers/login_provider.dart';
import 'package:avsar/presentation/screens/auth/signup_screen.dart';
import 'package:avsar/presentation/screens/splash/splash_screen.dart';
import 'package:avsar/presentation/widgets/common_widget.dart';
import 'package:avsar/presentation/widgets/gap_widget.dart';
import 'package:avsar/presentation/widgets/link_button.dart';
import 'package:avsar/presentation/widgets/primary_button.dart';
import 'package:avsar/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../widgets/primary_textfield_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
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
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
            child: Form(
              key: provider.formKey,
              child: ListView(
                  children: [
                    const GapWidget(size: 30),
                    //Top Image
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/png/icon.png'),
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    Text("Log In", style: TextStyles.heading2),
                    const GapWidget(size: -10),
                    /*(provider.error != "")
                        ? Text(
                            provider.error,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),*/
                    const GapWidget(size: 5),
                    PrimaryTextField(
                        controller: provider.emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email  is required!";
                          }

                          if (!EmailValidator.validate(value.trim())) {
                            return "Invalid email ";
                          }

                          return null;
                        },
                        labelText: "Email",prefixIcon: const Icon(Icons.email)),
                    const GapWidget(),
                    PrimaryTextFieldPassword(
                        source: LoginScreen.routeName,
                        controller: provider.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Pin is required!";
                          }
                          return null;
                        },
                        labelText: "Pin",prefixIcon: const Icon(Icons.lock)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LinkButton(onPressed: () {}, text: "Forgot Password?"),
                      ],
                    ),
                    PrimaryButton(onPressed: provider.logIn, text: ("Log In")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: TextStyles.body3),
                        const GapWidget(),
                        LinkButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignupScreen.routeName);
                            },
                            text: "Sign Up"),
                      ],
                    ),
                    /*if (provider.isLoading)
                      AbsorbPointer(
                        absorbing: true,
                        child: Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      ),*/
                  ]),
            ),
          ),
        ),
    );
  }
}
