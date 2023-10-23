import 'package:flutter/material.dart';
import 'package:trabajo_sumativo_3/screen/screen.dart';

class AppRoutes {
  static const InitialRoute = 'login';
  static Map<String, Widget Function (BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => const ListProductoScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
  };

  static var onGenerateRoute;

static Route<dynamic>ongenerate(RouteSettings settings){
  return MaterialPageRoute(
    builder : (contex) => const ErrorScreen(),
  );
}

}