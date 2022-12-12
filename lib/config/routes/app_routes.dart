import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/features/authantication/presentation/cubit/authantication_cubit.dart';
import 'package:store_task/features/authantication/presentation/views/login_view/login_screen.dart';
import 'package:store_task/features/authantication/presentation/views/register_view/register_screen.dart';
import 'package:store_task/features/home/presentation/views/home_layout.dart';
import '../../core/utils/app_strings.dart';
import 'package:store_task/injector.dart' as di;
import '../../features/home/presentation/cubit/home_cubit.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String productDetailsRoute = '/productDetails';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.sl<HomeCubit>()
              ..getFavoriteItems()
              ..getCartItemsFun()
              ..getCategoriesList()
              ..getMostRecentProductsList(categoryId: 1)
              ..getMostPopularProducts(categoryId: 5),
            child: const HomeLayout(),
          ),
        );

      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.sl<AuthanticationCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.sl<AuthanticationCubit>(),
            child: RegisterScreen(),
          ),
        );
      default:
        return undefinedRoute(settings);
    }
  }

  static Route<dynamic> undefinedRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body: Center(
                child: Text('${AppStrings.undefinedRoute} ${settings.name}'),
              ),
            ));
  }
}
