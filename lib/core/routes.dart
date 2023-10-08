import 'package:avsar/presentation/screens/auth/login_screen.dart';
import 'package:avsar/presentation/screens/auth/providers/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/auth/providers/signup_provider.dart';
import '../presentation/screens/auth/signup_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/splash/splash_screen.dart';

class Routes {

  static Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {

      case LoginScreen.routeName: return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginProvider(context),
              child: const LoginScreen()
          )
      );

      case SignupScreen.routeName: return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => SignupProvider(context),
              child: const SignupScreen()
          )
      );

      case HomeScreen.routeName: return MaterialPageRoute(
          builder: (context) => const HomeScreen()
      );

      case SplashScreen.routeName: return MaterialPageRoute(
          builder: (context) => const SplashScreen()
      );

      /*case ProductDetailsScreen.routeName: return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productModel: settings.arguments as ProductModel,
          )
      );

      case CartScreen.routeName: return MaterialPageRoute(
          builder: (context) => const CartScreen()
      );

      case CategoryProductScreen.routeName: return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => CategoryProductCubit(settings.arguments as CategoryModel),
              child: const CategoryProductScreen()
          )
      );

      case EditProfileScreen.routeName: return MaterialPageRoute(
          builder: (context) => const EditProfileScreen()
      );

      case OrderDetailScreen.routeName: return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => OrderDetailProvider(),
              child: const OrderDetailScreen()
          )
      );

      case OrderPlacedScreen.routeName: return MaterialPageRoute(
          builder: (context) => const OrderPlacedScreen()
      );

      case MyOrderScreen.routeName: return MaterialPageRoute(
          builder: (context) => const MyOrderScreen()
      );*/

      default: return null;

    }
  }

}