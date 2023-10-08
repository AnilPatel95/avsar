import 'package:avsar/presentation/screens/auth/login_screen.dart';
import 'package:avsar/presentation/screens/auth/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/auth/providers/login_provider.dart';

class PrimaryTextFieldPassword extends StatelessWidget {
  final String labelText;
  final String source;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChanged;
  final Icon prefixIcon;

  const PrimaryTextFieldPassword({
    super.key,
    required this.labelText,
    required this.source,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.onChanged,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider(context)),
          ChangeNotifierProvider(create: (_) => SignupProvider(context)),
        ],
        child: Consumer2<LoginProvider, SignupProvider>(
          builder: (context, loginProvider, signupProvider, child) {
            return TextFormField(
              controller: controller,
              obscureText: source == LoginScreen.routeName
                  ? !loginProvider.isPasswordVisible
                  : !signupProvider.isPasswordVisible,
              validator: validator,
              initialValue: initialValue,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7)
                ),
                focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color:Colors.black,
                      width:1.0,
                    )
                ),
                hintText: labelText,
                prefixIcon: prefixIcon,
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: GestureDetector(
                  onTap: () {
                    source == LoginScreen.routeName
                        ?loginProvider.togglePasswordVisibility()
                        :signupProvider.togglePasswordVisibility();
                  },
                  child: Icon(
                      source == LoginScreen.routeName
                      ?loginProvider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off
                      :signupProvider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off
                  ),
                ),
              ),
            );},
        )
    );
  }
}