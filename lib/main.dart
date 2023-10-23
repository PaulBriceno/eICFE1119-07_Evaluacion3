import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_sumativo_3/routes/app_routes.dart';
import 'package:trabajo_sumativo_3/services/product_service.dart';
import 'package:trabajo_sumativo_3/theme/my_theme.dart';
import 'package:trabajo_sumativo_3/services/auth_service.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
      ],
      child: const MainApp(),
    );
  }
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.InitialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyThme.myTheme
    );
  }
}